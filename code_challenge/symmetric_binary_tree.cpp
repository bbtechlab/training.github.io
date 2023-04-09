/*
 * Symmetric binary tree. a.k.a mirror tree, is a binary tree in which the left and right subtrees
 * of every node are exact mirror images of each other. In other words, for any node in the tree,
 * the value of the left child's node is the same as the value of the right child's node, and the
 * value of the right child's node is the same as the value of the left child's node.
 *       1
 *      / \
 *     2   2
 *    / \ / \
 *   3  4 4  3
 * In this tree, the left subtree of the root node (which consists of nodes 2, 3, and 4) is a 
 * mirror image of the right subtree of the root node (which consists of nodes 2, 4, and 3). 
 * Therefore, this tree is symmetric. here's an example of a binary tree that is not symmetric:
 *      1
 *     / \
 *    2   2
 *     \   \
 *      3   3
 */
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

/* Define a binary node
 */
typedef struct treeNode
{
	int value;
	struct treeNode* left;
	struct treeNode* right;
} Node;

Node* CreateNewNode(int value)
{
	Node* newNode	= (treeNode*)malloc(sizeof(Node));

	if (newNode)
	{
		newNode->value = value;
		newNode->left = newNode->right = NULL;
	} 
	else
	{
		fprintf(stderr, "Failed to malloc create a new node\n");
	}

	return newNode;
}

void DeleteNode(Node* rootNode)
{
	if (rootNode != NULL)
	{
		DeleteNode(rootNode->left);
		DeleteNode(rootNode->right);

		free(rootNode);
	}
}

bool IsMirror(Node* leftNode, Node* rightNode)
{
	if (leftNode == NULL && rightNode == NULL)
	{
		return true;
	}

	if (leftNode && rightNode && leftNode->value == rightNode->value)
	{
		return IsMirror(leftNode->left, rightNode->right)
			&& IsMirror(leftNode->right, rightNode->left);
	}
	
	return false;
}

bool IsSymmetricTree(Node *rootNode)
{
	if (rootNode == NULL)
	{
		return true;
	}

	return IsMirror(rootNode->left, rootNode->right);
}

/*
 * Verify the test case
 */
bool RunTestSymetricTree()
{
/*
 *       1
 *      / \
 *     2   2
 *    / \ / \
 *   3  4 4  3
 */
	Node* root = CreateNewNode(1);
	root->left = CreateNewNode(2);
	root->right = CreateNewNode(2);
	root->left->left = CreateNewNode(3);
	root->left->right = CreateNewNode(4);
	root->right->left = CreateNewNode(4);
	root->right->right = CreateNewNode(3);

	if (IsSymmetricTree(root))
	{
		fprintf(stdout, "Symmetric tree\n");
		DeleteNode(root);

		return true;
	}
	else
	{
		fprintf(stderr, "Not Symmetric tree\n");
		DeleteNode(root);

		return false;
	}

	return false;
}

int main(int argc, char* argv[])
{
	cout << RunTestSymetricTree() << endl;
	return 0;
}
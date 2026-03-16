Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE843EB7E2;
	Mon, 16 Mar 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687379; cv=none; b=gUN8RnpdLgZaMyjwxUNjnGrln25BczQtuoOz+zT4xlTKCNeOIJvahx0xSMRXPu3riAGnwQpiYalBgaaKdm100CRv2bL5zCuB7tpL7jaHo/vWa6rEzpQEs9kzXe5yccqc6WXKe8TwMDjBa1rLOn/SVThOflCWxeCTE0qYeILoPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687379; c=relaxed/simple;
	bh=sw1xbq7VZOzHUX3EH4LooAwQ0VYeep50madhwwKi7AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkZ5Eid53wCso7DuxxTLYdLXTG+GX9vfLt+ZvE1wB/je/fZG77jgJ8+8jYMgrgDJBtKnDG8CIl1Rq4GNwEvDY90/zNtSwY2ZOYf1Mu/YgbShYHTxQHo7gA2JXsUsjylMi7XQSBlIlAhVw0y7f9hjlaJADHHaDSLvWiPsMLr3Hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CEAC19421;
	Mon, 16 Mar 2026 18:56:18 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vfio: uapi: fix comment typo
Date: Mon, 16 Mar 2026 14:56:17 -0400
Message-ID: <20260316185617.166414-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file contains a spelling error in a source comment (succes).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'succes' with 'success' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 include/uapi/linux/vfio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..63d56c1fbf6f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -141,7 +141,7 @@ struct vfio_info_cap_header {
  *
  * Retrieve information about the group.  Fills in provided
  * struct vfio_group_info.  Caller sets argsz.
- * Return: 0 on succes, -errno on failure.
+ * Return: 0 on success, -errno on failure.
  * Availability: Always
  */
 struct vfio_group_status {
-- 
2.47.3


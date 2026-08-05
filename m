Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5B44AB9C;
	Wed,  5 Aug 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927846; cv=none; b=Af+bHsRP0GQWMA6Y5cb2ck1bHwFvhL8s/P20BetiElQGvnC5v+zsFWnNko21IGFu/8h4vFMWuk+TG09oEs7Zbr8xMSKOQJmlWqapSYa9cjznfbkfzDLzyzaRrtQ/chDEqSOK/wuha3o0acedjtUNu3I/jXwIJ30f4yjFJVknYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927846; c=relaxed/simple;
	bh=LV39BhhTwMHsbhRAOxbAOb/hdcXDE/lnyj1zgA65Kus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMq0T+L7XeI/Y6w8RThuVp5PoGmmg3tzs3hCh/9tuco2HeVvKlULQGkrD2ZLl9vM59pp2V5l/jnWf1Ea0qLx5NOkC6CF660tE7S5sqmyZVt+UwLVCx8Lh4rKYjPSkaz64Qqf9agOUUjZFWCebjptlUl/DgNoLAK1acPpOtWuF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O9jhX7nS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O9jhX7nS"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2225A20B716A;
	Wed,  5 Aug 2026 04:03:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2225A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927824;
	bh=mt1T9Dvgk+QbHOEIbidfgXuyLYVMdeZq2rT8kRKiGTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9jhX7nSrnEqRUppaIS0rhFWR/bxu36elJTyFkDP3TAXH6EPT4YS4/Er2oUojlHip
	 8UkSfVSjqNVcYyi4/NZJXbekDbzOYNvb5UU/3XfyAVF4qZEhuBAH8riYAF+KGGk0Jn
	 e3txE/1T1N/aK2ehlNWvb08hMmNQB6lsXlkZX/9k=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 25/42] vm_planes: drop unused per-plane vcpu_count
Date: Wed,  5 Aug 2026 04:03:07 -0700
Message-ID: <20260805110324.25067-26-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under the in-kernel "Option B" secure-plane model the secure plane runs
on plane-0's existing vCPU thread and is left stopped until the first VTL
call, so a plane never owns a distinct set of vCPUs. The vcpu_count field
in struct vm_plane_config (and the matching parse-state copy) is no longer
consulted by anything in the kernel: drop the field, its VCPU_COUNT config
key parsing, its zero-init and its presence check.

No functional change; the value was already unused on the boot path.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 include/linux/vm_planes.h |  1 -
 init/vm_planes.c          | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 47f05fa80039..1130557cf5aa 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -20,7 +20,6 @@ struct vm_plane_config {
 	phys_addr_t load_offset;
 	phys_addr_t memory_size;
 	phys_addr_t entry_point;
-	unsigned int vcpu_count;
 	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 	char cmdline[VM_PLANE_CMDLINE_MAX];
diff --git a/init/vm_planes.c b/init/vm_planes.c
index 274c0015fe76..10c7facdb1af 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -25,7 +25,6 @@ static bool __initdata enable_vm_planes_requested;
 struct vm_plane_parse_state {
 	phys_addr_t load_offset;
 	phys_addr_t memory_size;
-	unsigned int vcpu_count;
 	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 	char cmdline[VM_PLANE_CMDLINE_MAX];
@@ -275,14 +274,6 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 		return 0;
 	}
 
-	if (!strcmp(key, "VCPU_COUNT")) {
-		if (parsed_u64 == 0 || parsed_u64 > UINT_MAX)
-			return -EINVAL;
-		plane_cfg[plane_id].vcpu_count = (unsigned int)parsed_u64;
-		state[plane_id].vcpu_count = (unsigned int)parsed_u64;
-		return 0;
-	}
-
 	return -ENOENT;
 }
 
@@ -314,7 +305,6 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 	for (i = 0; i < *plane_count; i++) {
 		state[i].load_offset = VM_PLANES_UNSET_VALUE;
 		state[i].memory_size = VM_PLANES_UNSET_VALUE;
-		state[i].vcpu_count = 0;
 		state[i].kernel[0] = '\0';
 		state[i].cmdline[0] = '\0';
 	}
@@ -336,7 +326,6 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 	for (i = 1; i < *plane_count; i++) {
 		if (state[i].load_offset == VM_PLANES_UNSET_VALUE ||
 		    state[i].memory_size == VM_PLANES_UNSET_VALUE ||
-		    !state[i].vcpu_count ||
 		    !state[i].kernel[0])
 			return -EINVAL;
 	}
-- 
2.55.0


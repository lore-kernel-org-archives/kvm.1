Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F34314AB;
	Wed,  5 Aug 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927830; cv=none; b=pRuRcF2I50AEgeKxdlGkxViq1ZxLP0ylkQvouBpabF/3K/Qe3cQStLxrYoOgOgtNe0JxPRj24UGdmQO8rcSNONjHk6wGBhugYUuNGPTIlMS16EyLbPLTvKBh5Xc++yVddsZje/HiFO50DoY0gBZG6CVI/aMjqEkFC9mPOO/+AAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927830; c=relaxed/simple;
	bh=NCzTAqPe1CPtOwyiPAfxyC1Kikic7YuzixYDfQcexK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFZdl1yORDTQicj6Ix0GVm+gB3WkS9ttVO5037eGR1GTHosOQzfMHYYcmvjTMu/xUxirep1WlRTCnQ6zCx3yAssUevQ2IbTrpeQ4AukW3rwagSdu+F8GG32sGnCCK0cQ6D4W1HTVg9Kjrmag58u8+0sopYEoDyQG9F6uVk0ZlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CrI/cQwf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CrI/cQwf"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C3CC20B716C;
	Wed,  5 Aug 2026 04:03:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C3CC20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927807;
	bh=nngqIvDsOttwEddUkU8UUGrWpj5Z4UPAk42CUedgjOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrI/cQwfScXAxgW60vbQMlzsRJ8KFnD6wuMdj3masEuzWY/f5N5N0vlePzXrVanmR
	 jV7FDlb3fYwS6mhf2PRRjUrMhyPbIttBQgfOmXlR4uJSbMMbh/Lcj4wHb4XtMJZuvX
	 ynF7/a0svMheQ25LmIMpCoXVUQAxDcOsam8+6yz8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 07/42] skip processing plane configuration for plane 0 - plane 0 is the boot plane
Date: Wed,  5 Aug 2026 04:02:49 -0700
Message-ID: <20260805110324.25067-8-snambakam@linux.microsoft.com>
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

---
 init/vm_planes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/vm_planes.c b/init/vm_planes.c
index 8eafb1c5f8cf..ecfe8de409a8 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -288,7 +288,10 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 			p++;
 	}
 
-	for (i = 0; i < *plane_count; i++) {
+	/* Plane 0 is the already-running boot plane; only secondary planes
+	 * must provide full allocation metadata.
+	 */
+	for (i = 1; i < *plane_count; i++) {
 		if (state[i].load_offset == VM_PLANES_UNSET_VALUE ||
 		    state[i].memory_size == VM_PLANES_UNSET_VALUE ||
 		    !state[i].vcpu_count ||
-- 
2.55.0


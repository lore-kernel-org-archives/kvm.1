Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B838E12E
	for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089578; cv=none; b=ATC9GWiRpiTfH6QxlOPhE9V2J2u1fmonOugm1tZ6aK82b+3xyNdu/j8r/JjuEKk78Y4fDbPYBXXp0fC9jHexAddG/SW9i8mBH68dP51fyvRUAkIHBMueqbuFhTbzmFt1Th1byo5E2IfAPw+3oroDmdCWZeC2QLQI73ohVJDCgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089578; c=relaxed/simple;
	bh=cvM66anYgz9K3Mo4/Dx9OzmNjnvAQXpBRRxnW76ZNTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mr71z9cuUJf5zz314+gCMSfUVWCaaZZhv62OeBPj/IG2LVFdW3gdNz198tVyxcnPXXBo8YaSFbEP3b6HS2q42j4dLYaimlroDLlnFXA3+ARb9WpFJpJPk7+3rnznK3kwvnWE1Fb0XYmdGRFTxgDiog5AH2KcySyk4zZ+cs9lXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x42NsxOf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x42NsxOf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1277896014fso13297123c88.1
        for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772089575; x=1772694375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfjM/VAc0stWw4WShx/yqMtIU9xXg0AJdwokX5oM15c=;
        b=x42NsxOfL0jISnMXoER268+wsMkQQ9lYmiJuMKBBDh2G5ni0rEH5TA8dtixFOAnthL
         iuGmSCYorjFUZ5celM4U14UlVbRz8cCGz61BCpEX14WhjB9WpXIWZzJ7Ig1uyo4Zavv9
         s3xL/Jk3Pu2j6fcv4KOTbs//Nzh6Ts5WO2+Mm1qw+EOFHvXyL0hLyFVY4U9PxTfqDTxa
         60nZbIetZtZyv4pS1hfiWVoUou4SJW2yKU3MqRRwCILcD2g1iaovoyPGkG0Dooo3PfqQ
         X/PYB4uWjnn6jknBON4DvlyBl2I5rM81Ec3qkacVrn4a2lry8N/yis8RX4Xm50Yf5a3r
         pv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089575; x=1772694375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfjM/VAc0stWw4WShx/yqMtIU9xXg0AJdwokX5oM15c=;
        b=R43NADzf+Cg1IcEjK5bnhvYWqzTek4CYvpfimgAO3UHmfnZrhpfaCZU5SpH9RWSQuJ
         zinqIsHmfNdE1FNsy3c2nyQz4cp5R9KNxHXDBC6UksQZo661bXi6BwvoagObzxVldBx8
         RNOQeuIgmXb6zjhC+QhMY9BOc84yr4GR11jhiiFr5yqbgpAxVneby6firiBMFI2m2oQP
         HwGvBnCBu4lx/qXceJp6bN16GMXXSuwdmH794WWRju/2Sy60Q0V4EuAtA10qhiCFWSMF
         3j2QoGflUwYC4sxwR5NumOephzwmi3s+520NYRhA0bpuygzL4YhEIg7CBjc2Nl0UMN9T
         I50w==
X-Forwarded-Encrypted: i=1; AJvYcCWjD5baomRx9vsPcluEOgSVEPignveVtGiiXmz8+eZLHcBs7BZrIronZX71kLvFioUWfI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxOxoDAvgAi1fdGPeecWocBHkN/nBkZY/rb7qz6UuEWITDAZ6
	gA9SekZ5LmWH2SEwUAk/L0/CaOgzVx5mDIcjQbx2TY972x/VY8WOT89rWQYVnm+iUWo9fEvBdY8
	o/YONhw==
X-Received: from dlbvv2.prod.google.com ([2002:a05:7022:5f02:b0:124:a76e:bd23])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:626:b0:123:345f:5d9c
 with SMTP id a92af1059eb24-1276acdaa5amr6463857c88.2.1772089575384; Wed, 25
 Feb 2026 23:06:15 -0800 (PST)
Date: Wed, 25 Feb 2026 23:06:07 -0800
In-Reply-To: <20260226070609.3072570-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226070609.3072570-2-surenb@google.com>
Subject: [PATCH v3 1/3] mm/vma: cleanup error handling path in vma_expand()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index be64f781a3aa..bb4d0326fecb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1186,12 +1186,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
+	if (remove_next) {
 		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
+		if (ret)
+			return ret;
+	}
+	if (vmg->copied_from) {
 		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	if (remove_next) {
 		vma_start_write(next);
-- 
2.53.0.414.gf7e9f6c205-goog


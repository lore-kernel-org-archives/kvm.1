Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072B3D1711
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720036; cv=none; b=iB9RXtPSqYvZl1N/HfsFE5ynBPfqHmfk8sQXciiVraFjzS3e/PVaGhkjUu3tvhfImPRvl+NBhCbB9qYvm5np/TERaheMPtPP5l6KTddS9KDuAI10fXvPeRFZ/pliNyIDHdRu5A9B6otfvx3pGMTYCmHUxn/4UMhRzkjU89E9QYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720036; c=relaxed/simple;
	bh=9g5xp+VSVzzv6BVD0W5JIfINJEacz+YIvlhMB3lgGVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCoU489/LaKxKV6GN3zLtswhnqythlw9U85+ZZwVQ++Ydq3iZiQfrMcjRJAYcoJtRTu58VHKHGnXkFX6IF2VyxmlzCcuyD8V0maus/Z8lFPPNkhU5SwHxTo65+1H9TdAT/S8OR3XNr9+B+jBBTqplHyITrS7WWVRtH8nDbkq/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjKEuSc9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjKEuSc9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b461b36990so35839555ad.3
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776720033; x=1777324833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nGTpsdZingcIJU13AR/rz9Q7jpP4FQBt7uSTt0uhGT8=;
        b=SjKEuSc9rPn4nZM9krLI/6J4OmVjAHTDOmItNEhB8hzcuQnpBJ45HNJyxVsc1flGHV
         7TmJ6R2onZZdUYsmXWTDLM5HpaVTHlToS8gHFY6/+dE+swCVESbynJFhcZM2DZ8fAfJJ
         YSoT1/xK3k8ReOoRHmkkZGU0tkfxM5MCGsC8HrEVvucme6hb61H/XPBmwg3d6c51/OYM
         MiQuzhLoLzy5ZD6Zh36Ik/6f3/D3/F0X9Ikr5KOh5hwM7xf51BywJj6eUSK5dvjwqDxW
         guiYZfwl9G7ZpIMCephw5t1BTUC9JkCAZ7ievrj+j3KrIaXQBRAyPT70iLVt3KXjAzkx
         bYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720033; x=1777324833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGTpsdZingcIJU13AR/rz9Q7jpP4FQBt7uSTt0uhGT8=;
        b=BxKPZnmP9h3G+twjQMHOd0BbTjStKvAZjwn7WZECTWRCc28tFLt1s8QTF/KWeaFF67
         tJUsfc0QU9XD1H+joMXUfmsP86kxpZ7HMY7wyGDbjy+5R2PXRLI/OkNIbxtuan7v7NT0
         k+JnxJ2S8Lk6JQSOzCWrlXezlqOmhW/73MIs2D6gOPvJiqmfyCvTEK1lbVNBVeRxKkMj
         20r63VlLviNeJdPHRtc6RByAwN/9SwmIQv1w7n8p2gNJbDa9ZTrp/Wg2ouLec13xS1J2
         +UK7iAKzhbUUUA9kuV8K7DTJD7aKQ1Z2U5CEkiTxYcZ0XfWU2A++baBEJbJKDMpSFnp1
         m1aQ==
X-Gm-Message-State: AOJu0YxV04bdwCe6kPkuhlMP0Ml5j5jKttSE/q+ZDHRq/NKaR36boSXz
	R77vB32wGMS7iS45NkaSxALSFSlpCJi4vIbCTxZMma0uBYVq+6xmgy7QAgEOoqNLCacG9nJbGey
	EMHjH2A==
X-Received: from pldt14.prod.google.com ([2002:a17:903:40ce:b0:2b4:5ded:6ecb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58a:b0:2b0:ac1e:9737
 with SMTP id d9443c01a7336-2b5f9ec5ea7mr159040275ad.12.1776720033096; Mon, 20
 Apr 2026 14:20:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 14:19:59 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420212004.3938325-15-seanjc@google.com>
Subject: [PATCH v3 14/19] KVM: selftests: Rename translate_to_host_paddr() => translate_hva_to_hpa()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename arm64's translate_to_host_paddr() to translate_hva_to_hpa() and
update variable names to match, as using "vaddr" and "paddr" terminology
is super confusing due to selftests using those exact names for *guest*
addresses.

Opportunisitically drop superfluous local page_addr and paddr variables.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/arm64/sea_to_user.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
index 7285eade4acf..fb06b9dcb3d9 100644
--- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -56,13 +56,11 @@ static void *einj_hva;
 static u64 einj_hpa;
 static bool far_invalid;
 
-static u64 translate_to_host_paddr(unsigned long vaddr)
+static u64 translate_hva_to_hpa(unsigned long hva)
 {
 	u64 pinfo;
-	s64 offset = vaddr / getpagesize() * sizeof(pinfo);
+	s64 offset = hva / getpagesize() * sizeof(pinfo);
 	int fd;
-	u64 page_addr;
-	u64 paddr;
 
 	fd = open("/proc/self/pagemap", O_RDONLY);
 	if (fd < 0)
@@ -77,9 +75,8 @@ static u64 translate_to_host_paddr(unsigned long vaddr)
 	if ((pinfo & PAGE_PRESENT) == 0)
 		ksft_exit_fail_perror("Page not present");
 
-	page_addr = (pinfo & PAGE_PHYSICAL) << MIN_PAGE_SHIFT;
-	paddr = page_addr + (vaddr & (getpagesize() - 1));
-	return paddr;
+	return ((pinfo & PAGE_PHYSICAL) << MIN_PAGE_SHIFT) +
+	       (hva & (getpagesize() - 1));
 }
 
 static void write_einj_entry(const char *einj_path, u64 val)
@@ -303,7 +300,7 @@ static void vm_inject_memory_uer(struct kvm_vm *vm)
 	ksft_print_msg("Before EINJect: data=%#lx\n",
 		guest_data);
 
-	einj_hpa = translate_to_host_paddr((unsigned long)einj_hva);
+	einj_hpa = translate_hva_to_hpa((unsigned long)einj_hva);
 
 	ksft_print_msg("EINJ_GVA=%#lx, einj_gpa=%#lx, einj_hva=%p, einj_hpa=%#lx\n",
 		       EINJ_GVA, einj_gpa, einj_hva, einj_hpa);
-- 
2.54.0.rc1.555.g9c883467ad-goog


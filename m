Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411941D64A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040780; cv=none; b=uaIglA22YgG45V5k0ryhmIjbu4wm4lvNqXG/IcflRNMEGgw/kPEdk35CQMB28TNIpwR2uaKDlRH8HSx/uEYJMLoiOdYLh+qMtOiA3BayeHuAp74N1fibr+LpfFRDeK/IT1Sp2zPAL0ibQcqlV9h8GOqScW571vsC8Af9NtDQCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040780; c=relaxed/simple;
	bh=M2Ifb8ZR+HwA/H1LGAE2C/jP4eVMt+pmNz86ycTCoCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uKwf3JYQBJu+j3QuYxxM1kMrIezSWdRJJzhlOdIASzbZMqLJYoyfWHEcQ4XjK1haPnkCsh6/5bxIJIYJuA2TsAnc3BLx0LfzEzpw1VT8LtEeav/pdf2diNO2vFIgTGghbXti9utNPet4dniGrWqtq8n8cJCt7pg0c5UiXdbevhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnN6T+rM; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnN6T+rM"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so3433243a12.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787040776; x=1787645576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jHUMARs30oMku7rrAHEp5fhgY0hNDCAk+0nqtnlfj0=;
        b=gnN6T+rMWPC9082m84vAj6qSPGwgYKFL0R3y2e9DnWVFll1c292pkFZzqIqV6j2Kn7
         joXyDi2OZsHAP3gR6/bAnDfhT5EFZ7FeNqCTQEIr4/Di6EVKaUxvzvxHDPkcX6xK4aX1
         c5x6GfldgEZOe0isDF8u7kM4aHxm4ha/CVia1ABdaE2g55PlNZveRsGLYE8hVt6IaNgI
         EE7xqC3Tfcg4IenrM6Ius5i/RfjCGoy0YOrGjkd0nsCyXXmrHda28GWBpkM6sFTbuDOw
         HdTxwvPlhi6NNu91IN3q08/9vXveGdBCUNW5wyOLgK9BeQWHh4NRmyIk0vLYfF5eepFf
         021Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040776; x=1787645576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jHUMARs30oMku7rrAHEp5fhgY0hNDCAk+0nqtnlfj0=;
        b=g/tGENdfdtbUOtL1fII8lFo/KSkroPjQ3pmV5gdGmjAgh/YuTdSdgsOf6mAEyXj8/f
         iVIAxjjcnvF+T5GBXR6sHzovAlE16unHjDkbPEGnGUSbHhOS4K/aYoknLDkw+QGjOZRA
         2Nsct9M9AhhSKdRJ5NbfZFmIpJufqlj8N4o3qXI4SW+izUFlw40vptvF37kDMvjA8yaR
         OVc/XvmLaBFRjp1gBIpq03w9fIb3wVvWaWK9iFB64XfKhLsO3fWFfWGNbkLILowxpOO8
         UDb2NF8QnB/BQM6YOmr1yAHYHLrUPHwbM8IDDM+Tg4Ajujv5z3OfcNqZmcZCbPbaK6YP
         bz1w==
X-Gm-Message-State: AOJu0YwnfsVzEH0lMSX1ywIbuv3HzFfSm66K5e3nTCnYoG3QnxxIisTa
	dwrdxAs2MjTZ16UdgI0NXHFRYnkux+u5UMc1Befw/oORtlgPSzRG5IfKXLi9YWXhU4Lxf4n8UGO
	un4Q7okou32K49RTuKkmj29gYCQ==
X-Received: from pgdh4.prod.google.com ([2002:a05:6a02:5184:b0:c9a:37aa:b17d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f8b:b0:3cc:4d86:389c with SMTP id adf61e73a8af0-3ccda4b542amr9870906637.13.1787040776115;
 Tue, 18 Aug 2026 01:12:56 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:12:35 +0000
In-Reply-To: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787040773; l=2004;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=M2Ifb8ZR+HwA/H1LGAE2C/jP4eVMt+pmNz86ycTCoCc=; b=NMp2JIOD4jsbFJI/klpvqjQYI52qH+FRAQ3nl2QtSwfyO9la4WUlSpaEfhVwNd0VJlP0lcaCT
 c2/EcIXTH8fCy1k0RKSRKA3SJNRZKxQY4GJqvWPjQUHmryAYp7Y8Bq7
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v1-1-4f8d939efdbc@google.com>
Subject: [PATCH 1/4] KVM: SEV: Treat unassigned RMP entry as benign race on
 PSMASH failure
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

When handling an RMP fault, KVM attempts to split a 2MB page via PSMASH.
If PSMASH fails, the only expected return value is FAIL_BADADDR, which does
not distinguish the reason for the bad address. Hence, another RMP entry
lookup is required to determine whether the failure was benign.

Specifically, KVM re-checks the RMP entry to determine if another CPU raced
and already smashed the entry into 4KB pages.

A concurrent operation (such as guest_memfd truncation or hole punching)
can also race and transition the page to shared, removing the page from the
RMP table and causing PSMASH to fail. This can happen even if the page is
still referenced by KVM, because guest_memfd reclaim transitions the RMP
entry to shared when the folio is removed from the page cache.

Treat an unassigned RMP entry as an expected race when re-checking after a
failed PSMASH, and skip logging an error warning.

Fixes: c63cf135cc99 ("KVM: SEV: Add support to handle RMP nested page faults")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fcb41dfde4c02..b2738362a928b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5074,10 +5074,11 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		/*
 		 * Look it up again. If it's 4K now then the PSMASH may have
 		 * raced with another process and the issue has already resolved
-		 * itself.
+		 * itself. If it's not assigned, then this must have raced with
+		 * another process that made this page shared.
 		 */
 		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
-		    assigned && rmp_level == PG_LEVEL_4K)
+		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
 			goto out;
 
 		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",

-- 
2.55.0.699.gb54405d56f-goog


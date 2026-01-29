Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A3314D3D
	for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649340; cv=none; b=uCIXiezf/CrVbmfJR7NeYvj3bCCcgIsOF9V9M3pZLXHq+gb8PXUK495wJgyIjoyxEQHMsss/ut9cNuCh11nxaMOf4E2/Yv1oftojtD2RraPrLMEuiAOjO0moxzolmihXVietXNyaEzDNdNmaZIAwI/T5k5AvqpBp7mZucQVwqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649340; c=relaxed/simple;
	bh=i+BaQipwcwIk83xd9q3EaqDNGVAGV/ShuF7c8g62crA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/y/JIGkuBJVJ3DIgxLabvLR2LkLlK/SoroPyKbcB77nAqJJtq4fMftdUDLrTAKaBVOFQfSfR+pZsY+mA8C+ZsF3eGH6+OZ5BWwRPBp681dD/sXrBKr7eGyXI9tNuSz6i4JzS2eybSYBiF3xZE1xm6tuh1JjDxlOZ4NCZ+c2ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UsIwRae; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UsIwRae"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-352e1a8603bso361281a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 17:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769649335; x=1770254135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7CglUg76d+5MQRtd6QcMDKkRS3BGZoZjOLZ6NJir0yk=;
        b=0UsIwRaeBsjtSch/Ppnq8Y9B2FLg+XUcIqJJhbAD280Uv7WFo2iePwEAlL/KNW1Hch
         0x5mC+UACTra/Ja2iglZxoveEa9DWoL+TB/10HXJQ2v6pMdEA/3XqxMxcdzjkjOhyBhT
         yxKB0TpMUgC990yN99Pc/sKy5ZCnuD5jtnIrW4smXPt6DwiJtMK4EdqOH684LqyF5oF2
         AKd2KjP3El4q6nPzlY0VhQuV0K67mwyhaC33r4JQdm5QxuorRlh1NmYwpRxvBEcsvlUb
         byVuFpIhhjfSZO2+pBF//bRhPZt3HvOgldEC8+jFhVg7MG8nBXICx8RgZ3IKYadlyK+W
         jUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649335; x=1770254135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CglUg76d+5MQRtd6QcMDKkRS3BGZoZjOLZ6NJir0yk=;
        b=gvRvpm5AhR1WCb4xaltueMpKlXU7HaHxr9hA+HOdvSdGwUEOU6v1bagQLwo8gotE6b
         iTSlrIjzXiYlyOIxQj002dNYN0Wf1E66lC4eeDbbKmiYJ3N+Id3rGHmBA1MHyL8Y+ZCZ
         jHUiUpavRk0c0jL/t6/oZydg7p0MOHlO85KeB3jVTWXejSAfgLl1wxlTURz91iVdCmne
         IU5mRabjgkM9un/HX2axTCMQ+5X/uuu+bIJlv5jRbY1Bt1w/r1Nc6+S+HFD8j9EaIAEx
         ipw8zK0EntAcw7DpEi0d+EZQC4Y1purfBUiNS55ewC6U92N9CjpAFcKI//297AO/MDkR
         T0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeNxngWU34/XckXCP0TFB00OF+UHe9xWdUsQ8Npu6i8RZ91urRkFBm+fXw1Jx4fgsiY3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9JNuwciAEVHkanKxX2+32mnDA3tf6jmM3W1w0QE7t2Cg1pKF
	HQAti88tAgO2Mz9mAv3f1pcYxoLCEb6GT8iAcr12i9XBfa35b2iDTTLRhKL+5MfVBFyX8wcA2t/
	JYvQ4Ig==
X-Received: from pjbft8.prod.google.com ([2002:a17:90b:f88:b0:352:bd7e:99e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:314d:b0:340:ecad:414
 with SMTP id 98e67ed59e1d1-353fed8797emr5977548a91.27.1769649335221; Wed, 28
 Jan 2026 17:15:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Jan 2026 17:14:36 -0800
In-Reply-To: <20260129011517.3545883-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129011517.3545883-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260129011517.3545883-5-seanjc@google.com>
Subject: [RFC PATCH v5 04/45] KVM: x86: Make "external SPTE" ops that can fail
 RET0 static calls
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sagi Shahar <sagis@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define kvm_x86_ops .link_external_spt(), .set_external_spte(), and
.free_external_spt() as RET0 static calls so that an unexpected call to a
a default operation doesn't consume garbage.

Fixes: 77ac7079e66d ("KVM: x86/tdp_mmu: Propagate building mirror page tables")
Fixes: 94faba8999b9 ("KVM: x86/tdp_mmu: Propagate tearing down mirror page tables")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index de709fb5bd76..c18a033bee7e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -94,9 +94,9 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
-KVM_X86_OP_OPTIONAL(link_external_spt)
-KVM_X86_OP_OPTIONAL(set_external_spte)
-KVM_X86_OP_OPTIONAL(free_external_spt)
+KVM_X86_OP_OPTIONAL_RET0(link_external_spt)
+KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
+KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
 KVM_X86_OP_OPTIONAL(remove_external_spte)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
-- 
2.53.0.rc1.217.geba53bf80e-goog


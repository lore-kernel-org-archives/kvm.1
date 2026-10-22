Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702905;
	b=1is8QdFkkY8iHDjUj3wS0izJInUWmL8JxihX+BCugHHAGSj3keVOE/OaHsptCZFtsLv1
	 A7kFx7mBHfUevA69KC3tSM3Y1X9AV+T9liP1Ye83D7+7t4ttvVyVq9DWXTqO68s6RyG7z
	 FcPcjV18TDNj+OxXe956He7Uj+VdPz7fWhYnXhB4odRcnquDsVsXg6dHsct57zpopy0Yw
	 6uVFHmhwFRWvHWPsxJ4icKO/QAat7WLKcxmLEc34VIJS0Dpuk/segCyfR+nyJqwrCnLvo
	 zLYWKb2vHP+IBYhaM8kXhxxUZ/4XlLwANUSWmgU1pDYeIF5/0xGAXPDTDVol4l2NKrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=XC+w9Viu2qvKH/AbWhn/9WyIQrAbEorvKdSI99G+qIU=;
	b=hophEpeF3eySpsfgIHcNrB0q8n+ikZsggYwE3SdNGKtcooYsFHMcb7/BWFw0RtNW1HyO
	 ZErdxx4eLtcb8yk9GeazZ8+WvgYBoJxOZDn4JkzkV8di6EQI45kAgCoRgaWc3849qmlz/
	 Ah2g7i7TKWEo4U4SP7YohNBEQaY+9aOKc5XfE6UJJLATjdiDQCJCkz8p7oZ+Qu7hdy/l2
	 Xa69ROcriBKk3LxpSL8crsHr9ATrDFq580KjZnZwymrPldMo08yRUntY+xMJR+9YNFDo/
	 3XgvPaad1CBpBP4xcdmyhmbCjQlxII8qgQAsvWMYW9Cqh6ZwMGevSIeFsQkzZ50AcPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OAGQh1ep;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AF606A323
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29AF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OAGQh1ep
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0589ff620so185990b3a.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792702904; x=1793307704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XC+w9Viu2qvKH/AbWhn/9WyIQrAbEorvKdSI99G+qIU=;
        b=OAGQh1epfJHTzzkKC00Rc02e3G6EADCMR1FYg+BFxSqKf7JqEO72l8z/xtsW2NRzE7
         aIMn4ykNCXab6KyYeT9x+YM0b8B38SpGzPk40vfJAOWh2biVnNMwEVYIZYJW1UfnsdLw
         ophwiDmt+QVDlVsFElirdkHjMPIXT17TbpP1rVMvDyVkD1ZLutR9YvjOUc7/T5ArKrXH
         54vt5JFStsOEfUGnH1LGwfFy+b5PjdBCQZaGKVlVckuiSLZ/V9PRnWTtxZeU9dxZO4zU
         G1yGgWWmeZrySWveyYqZ62FczeIx/zAe7ZiilLp0JEIdF1Et4fsaKR9xg19g2XZcVyda
         b3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702904; x=1793307704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XC+w9Viu2qvKH/AbWhn/9WyIQrAbEorvKdSI99G+qIU=;
        b=qK2qQ+KoGvHh2jcPGHFrVdMHJcTFyGR80Id2T/afJb5DOOMD5qlcXFMK9IRfjdGS0H
         kwMxFJoXmDRbh13/ywwiyeb6/XwrhyA+WRK8hw1YllBxeYIxl8qDbiwaFFmkrbGV2mhA
         LOStv7lTUeiRvnGHHL201+Ye3hd6vltMOUqmhGGWt6lMDezrKsZQDuQZV3z93k/aaMCu
         Vm+iw3EPO64vDYyKQAiU1/OJUXxSui2XVqTWgm6Ztocm8INGqUqK2gG1UjBvU32qEBCb
         FXJA8wD5p9D6f83ABqhnVPhBLfyduOb/Ks3knxHS4+ke8S54kQWg7EKuLvupoNDdgwzj
         +QKA==
X-Forwarded-Encrypted: i=1; AKwUvBxc+jQP4PAf2IpLCbTTlhSKrDVEAMaPv1vBTA1m8iJ++KKRWJgdwfy0ueNsWdgqspfTS1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfaOqiMRpXOlq+r1+d8S5KqwmdoScOwVeK1HEzpaWKo2vUJd70
	9h2CouUz/izq0CwkXvhJhdiRQWXjbPJTevr45k+XLQW2v7DWRE6eCe501at1b7vgUIEAnSoTRT8
	QvjRMkg==
X-Received: from pfoa26.prod.google.com ([2002:aa7:865a:0:b0:890:3943:6267])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:330b:b0:87d:ee98:606
 with SMTP id d2e1a72fcca58-8a2c604340cmr293927b3a.23.1792702903840; Thu, 22
 Oct 2026 14:01:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:01:34 -0700
In-Reply-To: <20261022210134.612848-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022210134.612848-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID
 functions don't match
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reject KVM_TDX_INIT_VM if userspace doesn't configure the canonical CPUID
entries correctly with respect to KVM_CPUID_FLAG_SIGNIFCANT_INDEX to fix a
bug where userspace could bypass the TSX and WAITPKG checks by simply not
marking a CPUID.0x7 entry as being indexed.  This also sets the stage for
more in-depth validation of the incoming CPUID configuration.

This is obviously an ABI change and diverges from KVM's general approach of
"let userspace do what it wants".  In practice, no "real" VMM that supports
TDX misconfigures a TD's CPUID entries in this way, i.e. the probability of
actually breaking userspace is basically nil.  And unlike normal VMs, where
KVM has full control and thus can deal with bizarre CPUID input without too
much fuss, TDX VMs require extra care due to the TDX Module also reacting
to the CPUID configuration, i.e. KVM_TDX_INIT_VM needs to be more strict
than KVM_SET_CPUID{,2} to avoid creating potentially dangerous-to-the-host
setups.

Opportunistically rename the helper to make it more obvious that it's
checking if the passed in @entry is unsupported, as opposed to returning a
set of unsupported entries or something.

Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 37d088f6f7a8..6abf92ffec24 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
 		clear_waitpkg(entry);
 }
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
+static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
 {
+	if (cpuid_function_is_indexed(entry->function) !=
+	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
+		return true;
+
 	return has_tsx(entry) || has_waitpkg(entry);
 }
 
@@ -2393,7 +2397,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		if (tdx_is_unsupported_cpuid_entry(entry))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.56.0.257.gf7497c7d27-goog


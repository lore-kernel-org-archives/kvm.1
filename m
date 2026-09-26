Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396838B12A
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404655; cv=none; b=r5pqiQADkNmF4USMaUk8p/hKAzhJzhOzJnWHx4CRsaJj2zbL+BVac88Jg24IsV4Nmx8XHLUp9iW9dHiklZfLjkx1GWqtXAsczVngKPtKi7176i6PpqoEU6ZxaSA6vZ1fMIXAGFhq7SGWXK6UAbLAFwO8v6eHn2YV1FsquJwd3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404655; c=relaxed/simple;
	bh=4uMF+Zyheka+eW7kDUK3k8FRqJGU0Etmiqlk+J0Llxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMVKWnXgwxWn62YSirU9D76trrJMHEb8d8RDf1otBMfjjeiBmHNkF/HAcYaCtKgj8Wd6KjpW3li0eHFLDlrSpWHFPoFLI3BNyyh1fdSgZSzWXWtiEu+tzJ//x4uu8PN7SXt2csqJjo54XxLGy9MgwDcuEOEkE7YbzTK58OrPI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThY8gsz6; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThY8gsz6"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1473f265b82so89288c88.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404653; x=1791009453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtzEc8ALe2Ni0U200YE53lUimcTmcbv5pev4EjEWMTg=;
        b=ThY8gsz6vsuo9tV08Gq/VdQm2h6L00V22bSKLP37LYHAMtsY55eSV31DsV1s92+iZQ
         fM8ZOGMjjcjw1crB5n4QGlVANdPzls8UNwx4Po6D2QZEMYqVJhJ756T42WYL2ucZo5Wp
         QbgAgAHWmHaCnjctr5jN/AmvXS25RquQk/GSnGclhPZUOuArJpEXXZOSlpv6NlHIYXnZ
         blLx7LttXt5SHf1eOT7RjjCnZDeSgJ2Qb+IZsTjFWBklq5W3bLmOOouz03OjNbQJHkmZ
         VsaGzfwvRHNGgUUADCkPHoF6MsTMvpbO3f23MV0F03QGMkhIOV2Jal8hiz+zNyxdUn8y
         m6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404653; x=1791009453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtzEc8ALe2Ni0U200YE53lUimcTmcbv5pev4EjEWMTg=;
        b=H6FTzKLGT1r9u89CxVf9T4E6x1Gl00fHaOSxf2pCPBBRV8FOvXY+qrWqcnUh8OaRGi
         VXSrZI+5ilW9rElXc3aDdHAazm62Vd3hwONBMY3wPw8p/FmL1ddzoNd18GODmrmfVPcc
         G54vvu+Laf4kSzrkZEetHbKvGLtuDJowFldJUkV7ilLnqBHekxIL+x+Ha4Zd0S/C7JBP
         UnMzhy+YJFVnnjclZpjBB18keEByfllAx1j/q51lEDHxbonkJ5XpIikbRko48mmAb7VK
         PlgC09Nwq9fzPnNICUptJx4/guxHkZTtI8qUvggPoVOvclm88Zm04szvXw6CPOe1N5WV
         l3JA==
X-Forwarded-Encrypted: i=1; AKwUvByhkq9nVesKZRJ7vpvmaiz15CmNoOBAfYAK0rraqHfqfBztUlrM5RwCMjZep36xrahZUqU=@vger.kernel.org
X-Gm-Message-State: AFuF++kP1T9rnwSpbgGJdSbPNJ9YU0T6a+/n8q8qu4GkPusNPGDXHeZl
	unkr71NdHe6QmE8TtqvncxsqPFkbTDkQWrxtBUfQ7/LGByAUvEpkLR3amC4raIDA5w0zDA==
X-Gm-Gg: AYBFou1nZi/MwQOsWr4ZinAOv9shQ+mvTAz2x0M7J/7M0Du6l061uZ0W1ANEwSg5QI+
	aG3lEIYFMbpfxB7IPGbeby5VLNXqdFCNAoOzxAB5q6Yznclgah5VNiGfbKe4DCi9n1xTn4v5kgP
	aL8v5Dq2H3drmIJiAHQmo2IMNAsgne444QsuM3PSYo8AtyIqvSkyWNtv8+558Wpp1U1HwQdte0E
	NkHMU0dLNap65STMrhVM2x5Oz9jAv53EQNnoEgMLaGQK6eoLWF/ogH7HO27wOpeQmOF2q5qKCPL
	dINGpvxj4yA0egXMFtjYbRvJ9szc0BjRJsUgM+D0qC6qerinziW0cFMJFh39K60tHqVT8KlSKw0
	Vy8Ylp3Q6s7jFEJWE1u5LzOiCHMm2tfINYlrbJL+3nJtoyilTW9FDqTNriz4FiZG4j9UM5DTpT4
	d8t95D53CJH6pkLSQzWYKfcpR8X7DIxgCxWFBwSKfQLyh/CcFrAUWW+A8t/1m2ODKH6GSKh6GnL
	VxRDNAEe3HWk6bjS8+gjpXRi+xfRXgW
X-Received: by 2002:a05:701b:2618:b0:141:5281:8a41 with SMTP id a92af1059eb24-146cdfbbbf1mr1748789c88.9.1790404652850;
        Fri, 25 Sep 2026 23:37:32 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm11239841c88.13.2026.09.25.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:37:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Rebuild MSR bitmap after eVMCS control changes
Date: Sat, 26 Sep 2026 14:37:21 +0800
Message-ID: <20260926063721.1471741-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Enlightened MSR Bitmap shortcut reuses vmcs02's bitmap when L1 marks
MSR_BITMAP clean, but the bitmap also depends on execution controls in
CONTROL_GRP1 and CONTROL_PROC.  L1 can change either group while leaving
MSR_BITMAP clean, preserving stale APIC_TASKPRI passthrough for L2.

Reusing the bitmap after a failed rebuild is unsafe too.  The failed entry
disables hardware MSR bitmaps, but KVM subsequently marks the eVMCS clean,
allowing the next entry to reactivate the old vmcs02 bitmap.

Require both control groups to be clean before reusing the bitmap, and keep
force_msr_bitmap_recalc set until a rebuild succeeds.

Fixes: 502d2bf5f2fd ("KVM: nVMX: Implement Enlightened MSR Bitmap feature")
Cc: stable@vger.kernel.org
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd3..0f0e677d99482 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -755,13 +755,17 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
 
 		if (evmcs && evmcs->hv_enlightenments_control.msr_bitmap &&
-		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP &&
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1 &&
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC)
 			return true;
 	}
 
 	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
-	if (m.ret)
+	if (m.ret) {
+		vmx->nested.force_msr_bitmap_recalc = true;
 		return false;
+	}
 
 	msr_bitmap_l1 = (unsigned long *)m.map.hva;
 
-- 
2.55.0


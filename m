Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672221;
	b=CymLvJujkW4PY2LzZ0r/fiKpIDOWcTW9cCsiTVR+X6tBHdHfn9MRi4gW4o8qeH/AkP19
	 nBYUgpXsg4H3xkzUJlFpt/AOKBpSRJIAUoIlxoJaznvBgH1lMkG4FOaAd2qTO3iD0bLNj
	 Mrv5Wv2PG5XIMldtVwgQv8SCAfB1sYp9+PvUOmmH4Y1bB+aEgfjjlSH4nVVEfX4MQVbSy
	 VE9BAdRumrn5r5NQY3oa2zty3YleY/tL8M5e3jW+ifs/pWNUyUbAuA+eHUrZPjCcKpzLb
	 jzRYlDii737VpaEwV4z/A2KOg4KQR7UG7dOLhPmBNGzDqz4BO7KHOQxfx973vPOTpmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
	b=YcugbR9+v8sd05uwVyt6ec0107xsrzE9N1/QSVv/SDA1VUVJCbZgjWD3R3gmpkOBMQvH
	 2NsUF6alUw301lYamm74wIwP0HYzpn7LTZPX3pXBMAa5TMgaQKniSeSvKbJteXcGa7Nu1
	 M+32/DeXmRv00cgYec3a3P+xg8JaQ1yD2moyS/8JvUCheU/HOs/aoL5som+uKsW8gc+57
	 Pz7x81FKvL1fcXrllxFeHMpnTkpZhBxMboz7nPVjJYpy5Ss9V/izGR4z1EolIgOscGNru
	 PQJ9gVBAqQ0YJsLvla0OBImQ0K3dndhWUUejmf2Fb4lLFwfeLesP7JEg1muu3PEnJDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFeGi6oK;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29C606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 02:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B29C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFeGi6oK
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2544669b3a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 18:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672221; x=1794277021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
        b=xFeGi6oKTGL99bE6SUlm0Mom52pPJKiBe5UZEoYi7l9ccEdN2Bz6NpeweBzDsGuWsA
         SZOmR5SwuDI5YXvjLMiHEZszX7RJ9i3D6Gumrg6kkHP3aNH1oLtxI6nw6dOkY6q2Tn0G
         oRhB7RrweZcmspQuF6ZWJmXlAjGru4eUEWXSfutDspaqzyWdsg7YwKu0UJYECUeyixYm
         3ZyF78/chjzNXBaSnLpa8hM+u9tyA3m6zEB4CCHnwkUlGjBpcwIQx1znQB7Gkfu6ICrF
         BUY7NwMTOg/viqnq93m2jXCqCYiUGlt2kYDVC3PK3hOnLp4kp5CnzZ06NYzX/kZdir+B
         dSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672221; x=1794277021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
        b=e726qG6ryp9bnXzKcRyVMLrfJOAB13Si1YLBFZb4Q6vEfmsiu6bfAvnOYqV+PMEnMn
         /YXBlU2emcy6D/nxiSniqfrRdXYnJNcuthJiK4kHN4AlsHfRAAhKGvJdT9fHY3wshfHv
         bd6M9fq4PCcP6vXzh018D+avzzqGHxQAw0eWa8+Mhgc5feJznYLz/RnFi15O+evRMFmh
         u4V/J8bhYdD0w8u+EVevcZKeS2Qt1d2lnNJ4Xq11kc0eGq9fL8ia9RTKGLUNG9x8NF6b
         Ihh4+U+HBxIrZ22CdyN903DwvOfDhSidoXDaBk4v00LdDtY4qP0O4eDWBl6laJ8wkGnw
         hsLg==
X-Forwarded-Encrypted: i=1; AKwUvByh5Jl2XtmkT/YlZUgU3H8MUzhW3A24yH9glJYj/fFsrg6zDz413gFWjwf8OxYJ8Ivy5eQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q1XCQdjn90S+no2AGstEZT/IjK39St9pf0hMTZAk47CQvQ7L0
	7B8m+aTYYfN47F194F1+LhxTHwoPVGE43z2U2f6B8XOHJnMrv4PcHNRT
X-Gm-Gg: AYBFou2tI1oh7G0uBBf8LYgk6a6saVgpE+LK0c2NEiyIAuQ8nGXrHJ1s6MRHlJUzlFs
	TmdDAp9rltTP8/2+Q6h6R6vIRPfyDu1DdBycU9Jg4+s0VZV92ToOi+NDu6hSwLnZzDvujwbFyga
	6dWIdVCWuGpELfB4+uK96yIrd8SFJBdHM2//fgkO7+BEbVFF0oj0LmDWvtyv4CzLQrBOZisjJMj
	+dm363uYxnDOSXOp6FGDFp+iVst1gjoFmL8Vk1vzhzXfkqENLOWnkijedaJZQW3thj1yGCaoxIR
	o7tCJL4Jz2/UTY1zcQ/z/B0/Mz62b/W6Q3cv+CvleUiH93B8Gynu34Vbhmev9WypkR7jNH5VSqY
	0y2LGWA89Jd7NJQbYqHMHodTZ/GAT5wkRNIbnVzNOkmL2s60B0vDPpHAxHX1YI32+pkJ5oK4fWz
	pV587ZenG21aAx3uNP1U+2Oq5bIIGbMw2VRR26MdfM25YDWqiX1/HT6Xz60iyS1kvSk2FCRO4sr
	xfBwcKeDdiCxF7X3j6Bg+4477P63gehL5VPZ8js+x+NVsAGgL2n5h+YP9yXYLn/DeTWms6LfoDn
	zCt/3A+8WJwjiZAnYQd9I8TWRQJ1E4hQJ76rUhzyvUE=
X-Received: by 2002:a05:6a21:3b49:b0:3e1:d379:f3b3 with SMTP id adf61e73a8af0-3e928fe8569mr7948733637.77.1793672220726;
        Mon, 02 Nov 2026 18:17:00 -0800 (PST)
Received: from iZj6c0kydq3fvfrtx5kta5Z ([47.86.51.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36448182sm490457a12.6.2026.11.02.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:17:00 -0800 (PST)
From: Challvy Tee <challvy.tee@gmail.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	kai.huang@intel.com,
	seanjc@google.com
Subject: [PATCH v5] x86/virt/tdx: Gate TDH.SYS.DISABLE on X86_FEATURE_TDX_HOST_PLATFORM
Date: Tue,  3 Nov 2026 10:16:50 +0800
Message-ID: <20261103021650.924302-1-challvy.tee@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <09c311c6aae214c04a9a55ff6456d7abfe82c319.camel@intel.com>
References: <09c311c6aae214c04a9a55ff6456d7abfe82c319.camel@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
kdump") made native_machine_crash_shutdown() call tdx_sys_disable(),
whose only gate is compile time (CONFIG_INTEL_TDX_HOST).  A kernel that
never initialized the TDX module therefore still issues
TDH.SYS.DISABLE.

In VMX non-root operation on a SEAM-capable host, SEAMCALL causes a VM
exit instead of a native #UD.  KVM injects #UD only since
commit 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute
SEAMCALL or TDCALL"), first released in v6.18.  On an older host the
VMM gets KVM_EXIT_INTERNAL_ERROR and the vCPU never resumes, so
machine_kexec() is never reached and no vmcore is written.  Kdump is
thus broken only in guests on SEAM-capable hosts whose hypervisor does
not handle the exit; plain kexec is unaffected because tdx_shutdown()
only runs as a syscore op, registered after init_tdx_module() succeeds.

Gate the SEAMCALL on X86_FEATURE_TDX_HOST_PLATFORM before issuing it,
the way paddr_is_tdx_private() already guards its own SEAMCALL in this
file.  Without that feature the module is never initialized, so there
is nothing to disable; on a TDX host the gate is a no-op.

It also decouples kdump from the host KVM version -- a guest cannot
require its host to inject the #UD.

Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Challvy Tee <challvy.tee@gmail.com>
---
v4 -> v5:
 - Update the subject to name the X86_FEATURE_TDX_HOST_PLATFORM check,
   as requested in review.  No code change.
 - Add the Reviewed-by tags collected on v4.

The reproduction data and the host-side KVM log are unchanged from v4:
https://lore.kernel.org/all/20261102073244.919864-1-challvy.tee@gmail.com/

 arch/x86/virt/vmx/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..9b01131f7b7b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2321,6 +2321,9 @@ void tdx_sys_disable(void)
 	struct tdx_module_args args = {};
 	u64 ret;
 
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
 	/*
 	 * Don't loop forever.
 	 *
-- 
2.52.0


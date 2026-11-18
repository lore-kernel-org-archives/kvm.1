Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984020;
	b=4AjCYjNvMSNcHqN0cLw3Q83VuIzN/Jsrad6xuSoazNYvlCbBakMwM9jUohCDb4RZ38TZ
	 ts7+KxVkew8IZi6tbQqaUF/PiWfVZrDMc8fInvYzZ8c8Uh4CVJ/Is4c99kyFYSgkL3kXy
	 JghParWZX4TNdHwv7bgaWalhEvxIVtNQ/8qM8G5Y+HhLe/m9+YskFS8/nNaDFQ39RqMI9
	 XZlAleL1/bTRA3Je2Yq4RsNBrZjzEo+7Om/uh3yxVjU4mX+PKEY++XDJ3TAAv8RTwcKxd
	 SVTvuX1iYCEONCBIW+YQLNZ6QWt8f4wowLhookGwVb7SYA+tJ0oH2Xnq/CI0+NAH3YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984020;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
	b=FFaRfhpildKto1gcrV5H0ejCczfxf0Bi3uVTYaGzan4TL5FxbkDQIiwAonv5+pJUxMJ3
	 G1F6eK8gQeInkhpArGd7JFtDkB3ufqfTZvjstMa0oVY2wA7P3s2HzUw7kkG8Mcm2bGA/u
	 c2MgvoU+0PVpGH5ydfgRKnEFz5ywqx9GUeYpL0anKEAEisA1y+ZLD3HtlQQTEIYnHA0F7
	 NJHkIT4dX2C5JCo4bcBNLWmm/xg0ESamW5eobN6Ex5/XntKqnynWwIZxzeltedhEaqLQV
	 uVuTVcRIyqouNT6SX09ow8d9mzyVfx0WyJOLIcGtHvaELdDMKFZ1goC3y7gmIzdgPnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VztWVw93;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAC606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 06:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33AAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VztWVw93
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso375626a12.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984020; x=1795588820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
        b=yy0FZildDjd5DGPNIH+Vxll+A91I0PXzUE6t5GoQKenUSfrGToKPm60rJEGf1RMz0Q
         3E1bv1MwVAC+uQYpo5qQnQE86TZT1NWvABnyFHgjbJ5JgAwERljJnDzpz8uZzU5H4pj5
         aV/6e9SMp11WgNFsK47cElYeTLCSxdK7yjC0DvrbJ8ytsQkH7VmHp6j1POQaFC1KyA9L
         mlwF14tvjTV2KNf9Ua1R7oTDMPbMUxGlwg8D3CUAqWJs+JbJf8fxX+yn34iKhCopJac8
         t84CG+s4rVBgodevtZacTjokNqyzK0VM4QaVHnf0BBfNKjaRIxZUCZLZEtch1BALIpaS
         vgng==
X-Forwarded-Encrypted: i=1; AL+hErEpzPQspAV37op7ftHdUvThWWCTPVmBzZW97VOI7+pJ/r1/NbyxQEKGkUThy+LP8UE9A/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZGIdpYla3Fn7QrDVRK195DRkce+h/TaMPs14C0xIv14geBtZ1
	DyvEPpMXTa6r7zKTNtp5WuJarUr1pJY8p9XnAr1bqyn6Upe7ZfBmMTJWm15V1EF3aXG8nwES/Zk
	cnZ1dGYlVuAIiQA1D+zkVx059BYN3lYni0J4/XArevGeOthdxgFNCCBMBl5Xw7j0IzABViKSEYa
	cnsKK7hfx3ZYyjvMwY2OuHk1Y5W/BmCjmI1J40tTh3muAix4nO/5CR+TNVplsqHFh5uRQ1pq6hJ
	QGp
X-Gm-Gg: AZFdTZe2BLKTA21cUrzLJdPXbF8133L9uts60c20WoKgy9VQV7gC2mUGUtssNDq5JZP
	XYiXpcswOm6vuZHsBlq7bHlIMp2BfoGYvstaT5nyxiTshx9oyde/dcOLa+lq/9uSuTgYxdhuD9Y
	1y3IK32rxQJ10ZzWZIRuNyilYBauGLgBupWaonsVTSTCEOji9eOYbCYE/eoMo1uvYQTeXRGYHw2
	O2PZ454dHD4Nmi7mgj23oIJ4a4TxejtqC8mqE4Qq9AwfuVaSbe99AHkZ8dF3G9RZG7mKi4QDLmK
	iZHZRNZ/J2YvgBGb5bKD1jWuoqIhgHpnghmPnr2K6b+6M9/SLd2erbLFoVv2Oufvfr1PpcJGfyB
	y9U3IKF3oq5t3iwyP9ZPZb5KOuySnanuAB+Vn7BJFCbWB/ckcmJI6TzCGIRrU3Gxu6orWxQ5+2Q
	7Zo7tvgOlan+fbmqCOZoPkLYchSYKQorLD
X-Received: by 2002:a17:90b:1809:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3b3d07d4406mr1479416a91.43.1794984019564;
        Tue, 17 Nov 2026 22:40:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d14c0525sm1272915a91.8.2026.11.17.22.40.19
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:40:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-92114c39cadso11074006d6.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794984018; x=1795588818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
        b=VztWVw93TzE5FZPngYY2lR/djU+aBLHel8A/trWy8lZCz5DYUjvakuDehrXl/+OtG3
         pgo4Ae8INRlZsYeRNGkwkRQ5EX+ltXxQmKPI8rAFjOwF1TTvhQCM5ZBPYBeHQfDdhilN
         /gEiZ0I9JEIeGNLR3kXa6f35LEpCuJIJ6H1UA=
X-Forwarded-Encrypted: i=1; AL+hErGy1If7Q9FaqItzu9HZD1PDTaJp+NlOZwCKpI4zQdE18FzajY5m2tNaMxDDNLUQpyWOQqg=@vger.kernel.org
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id d75a77b69052e-55d5a7af113mr24847351cf.77.1794984017836;
        Tue, 17 Nov 2026 22:40:17 -0800 (PST)
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id d75a77b69052e-55d5a7af113mr24847041cf.77.1794984017277;
        Tue, 17 Nov 2026 22:40:17 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:40:16 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v4 0/3] x86/vmware: Clean up the hypercall code
Date: Wed, 18 Nov 2026 01:40:10 -0500
Message-ID: <cover.1794206170.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Move VMware hypercall assembly out of vmware.h and select the
low-bandwidth backend with a static call, following Linus's request:
https://lore.kernel.org/all/CAHk-=wivx7pi+h+hGmvNFAJm6StQLiQ-b8DdsE5J=LMOWae8Ng@mail.gmail.com/

Patch 1 moves the high-bandwidth helpers out of line and removes the
redundant vmwgfx caller annotations. Patch 2 uses input and result
structures for the four low-bandwidth backends, selects the backend
during VMware platform setup, and removes the early dispatcher. Patch 3
retires the unused VMware feature bits.

The caller API is unchanged. The I/O-port backdoor remains the initial
target for early DMI probing. Modules use the exported high-bandwidth
helpers and static-call trampoline; the static-call key stays private.

This series replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1794201807.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/cover.1792471114.git.zack.rusin@broadcom.com

It is based on v7.4-rc2, which includes the i386 high-bandwidth fix
this series builds on: e0e022004bbe ("x86/vmware: Fix i386
high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v3:
- Forward TDX guests from the backdoor backend to the TDX backend,
  restoring the pre-series ULONG_MAX return on other hypervisors such
  as KVM instead of attempting port I/O (reported by Sashiko).
- Correct patch 2's description of the duplicated assembly.
- Rebase onto v7.4-rc2.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

v3:
https://lore.kernel.org/r/cover.1793685318.git.zack.rusin@broadcom.com

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 307 ++++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 359 insertions(+), 326 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

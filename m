Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690612;
	b=ovzpANuJeZOqryXfGqp/CgX0KkRBEvqgalTESEmwdTcXe/j3SWmNpywKAoF9uMfENyJY
	 fXZ/FjPhCPZF8u3NIMqCOOoQiNr1HF+OPQXM+N5T1MRePjEbD9v+wiV9aoquPIYo32ngH
	 lN6EPJYmrFGkj9Klw8jskHRNQU8HgdW9FmfwjSwMSRgXofcBuQN/7MV3SUC0YiVtqW4d9
	 NecN43rTqw7hha9v7VieNfYdiBUq/LYxhmppZ8H5o3he2DsQW9TrIDmvWyjf85fV/BLV6
	 AlQBM4AzCUSHt5f/75OeisS+uNIa5wM8ZYIiKm9rj5dTZmIsi/cWQp2WFHrWxCXU1Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690612;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
	b=KaLoh1aMNr1UG++ZYJV7q6f/58UhdjUkBbWs6zk86g60hLYwKOyPBBCTaU1uM/tjbaiG
	 73SPldmornQSEsaKNY1K9sXNnfvpiKSrENpp7KSvW+VOdc0v+3rXEdtI+n86SH3AGDirl
	 Ur7BlGUKZx27JfcZyn97L1DVpdxNp4gGxDEhptvKoQ2kzBnlDrU4MPN12LAzua4ZtzmF6
	 LTI7DGaaWi9EBC1p+b9S97yX1AGtFl32HysIVzK/j94AVM7hDVAbgtumcoI+HF6aYdOWP
	 oKTh/ZTohk3DJz3Qf3oewiS8cJTvWGfb32+adHW8S+wUKnXrh5Ydjn6+KGV9Xi4t7cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="gLA4O/R6";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE09606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 07:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE09606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gLA4O/R6
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so4181766a91.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690611; x=1794295411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
        b=r5Znc9iyR9JPkL7clIg5Ne2fNCj+irKWNY4pAudtcDMTzSTZ4HNz+85xD0kmh2bmoD
         +6jQBnqCmmoqSAqUpy3d5nVLQu5KOuFl7NJxoCSfoJdSgxEbbB9dlV5pC8jFTpCy6IOp
         mWOCp78tb+RHtFxevfpIhoA3dQLmjZPQJaW2NY8WlRlGHEumpDSJEUHqvFC8fduoH8Ki
         6FqVTLmSgTXJCRnVePo1CtOiQeUOLYOOl9IhRqgpA83FsD6sdftbHZeBvuIwP0rK3ej1
         2h0UqhE2VA9T0q2YmTyjDOzQDONExmBPpQoAQ66arCxIwC8/zX9KyO1G1LmzwG8MJVhn
         2i9A==
X-Forwarded-Encrypted: i=1; AKwUvBwpwtKh+nnv46RAZp3tNiACRw6NdTaBn4aaAHFfT7mYbbF30vUFYhSJcl67DeNmQudBYCM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iWaY0IA0ZKk7ob0hsu+xrz/AwN6EfvXW06NRqXPEFP2m9F26I
	wzOX67E1rGuwNOq/jRtEOH61e8WMkSxVJm0oo4rBNobe7fAWNNPd9hLYmZCg94m/dAbhlpx4C8d
	/f/GI3xa+qaewq++U+ULoSsjzk7V+0wjfqAO1o8MQ7VCRaqDK4zBkf6GNmbz5TexM++W90wHMm6
	HJ4TVROCbadZtIHGmOzfYQzeKyueBy5x4DFvgvkbFRzNpFFUF77i6Av7ZIb+Un+Y1ZcfbvkDkh4
	Bt+
X-Gm-Gg: AYBFou1qDsxf9JqOASUQUDBV301zgMI8YE//UN5Pvo/tPh+ynQnSNqoOrMs+4GDGyjz
	wdwBR646DVU9WP3TAsnvkJXUAcEzj5U9CJeHJHHtMcT9zgOin/INNrBTKofrwklvYCO3B/oLjl8
	Uoh5oMQk0VIPutI2pkcMMx0f6NpEBY8L24f2GNvjZlz9fTGkpL6ZNN4gOPSs1XYnfCX6Dt7em0l
	OlcFctyRfkO/tVVJNYz0uNEBasHyk/34YAseXkkljkzaZ47GOabOBO+hP/hc0JDDMuS5e/MyEDT
	2KlB+7aflPaaLfZeZXszZN729d1eHhXrxZaY8YBlsnPjHkDvqlzLnjttqPqBdRVq+CEZLKtFZT6
	sj21nPUPTh3LUBUDUE9MrrK6j1g7XmyfOhpmvKoH7ciuq9IrVM/jSVOy/vhHRhFijDrzN6hhItg
	x9zNzSioNvjcVN18Q+u6Wf65jQOi7b08/G
X-Received: by 2002:a17:90b:2e52:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ae897ec759mr10084058a91.25.1793690611026;
        Mon, 02 Nov 2026 23:23:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07cab84edsm1245916a91.7.2026.11.02.23.23.30
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:23:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e941532594so43405755ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690609; x=1794295409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
        b=gLA4O/R6bR8E/M917zNE57f9vD2ITpZY3T3ftCkbPZeduXxw0QyTwdbBdkPRa9nP0+
         FAcm7DVxZc6VNIc4G2HXT/31Ebcb1ajO5G2E0MAq5888B1Qh/p+sKOsvwp2K1tzRfEpS
         enKnNIkwM7pPxLBrPO8+LEaIW7m7kTWMXlLbY=
X-Forwarded-Encrypted: i=1; AKwUvByiqtt0UHwup+nvrrxc0HHAy60SEiNlD5fypkJtbucBBQlf4PwnjJhnR4tTpVk+x24MWlo=@vger.kernel.org
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id af79cd13be357-944216b1af2mr2136143785a.28.1793690144072;
        Mon, 02 Nov 2026 23:15:44 -0800 (PST)
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id af79cd13be357-944216b1af2mr2136140385a.28.1793690143503;
        Mon, 02 Nov 2026 23:15:43 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:41 -0800 (PST)
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
Subject: [PATCH v3 0/3] x86/vmware: Clean up the hypercall code
Date: Tue,  3 Nov 2026 02:14:55 -0500
Message-ID: <cover.1793685318.git.zack.rusin@broadcom.com>
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

This v3 replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1790014793.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/20260929040256.543767-1-zack.rusin@broadcom.com

It is based on tip's x86/urgent branch, which has the i386
high-bandwidth fix this series builds on: e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 299 +++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 351 insertions(+), 326 deletions(-)


base-commit: e0e022004bbedc7caf1c18770980eb5372019189

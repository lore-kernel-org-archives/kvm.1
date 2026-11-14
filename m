Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624537;
	b=qjR0hOjv+fq5ZVl1PY1ygRqf+YCQVuQSjd8RcBGII7s/zrlcqI40t6Fz8wEHAv1hMWDQ
	 lxNT/2asynwZjLYIBuxpDFYl406Crsgde/upM0n3e/T2tKxEbrgvjZRTNKbtzowBx2m5U
	 +jwcSZbjs/EvAmMaoQonGBFbbwQsvCLMtIbkHXd8ME7KLphNoaeSmEpOqLqoMAxN0swT2
	 oNMIn0UF2Rc3xFUC5Ojdtx5FTqYQyfdZuP6iuOyDnEfXehx+gntMGcc//fwkC1EPHOKVS
	 kAtu8+9eeX8iALbHBrdi2QZMvywQ3DUw0nXOdQIHezj9u/t+4P5wTWYM7iXLgEv3VNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
	b=nrG9zI3RFbBQWjxKUReMKBFHfJDZs6SLRJsvm9FChzym5pLh6oD7G1aiVVb+IyjVpvbR
	 fYR8GO0xQUGBRYH1at8/rf3pqe1YwoK2WG841d/Wadih6A25DT09qKf+RqdGAtzVEOKyP
	 kdLGKAMaq4+e4/+h5b4olORWHRo0a1wyQb8QsyxJ9fSChhpVNfJOmhVK4/5KiAZJnCkZi
	 +0qD/N8L34HHModokhhxvUTJD9KDwnwakDEMjhpzbzG4rtGXSWuzzlpoM93IBbgXQ2tHz
	 ICxFhiD/szECGezGjpsR7hVJY6fB1crcDCzXGTrDbgPu6LBg7+8uv+11MFkhl/0d/PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=in9iqHN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0880606A329
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 02:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0880606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=in9iqHN0
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c5083bc0e28so318004266b.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 18:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794624535; cv=none;
        d=google.com; s=arc-20260327;
        b=JxRdhk3JUe2dimQKRj2UnUOvZlNBIdnWqOKosFHR4G7T0FfVa83Qxq+a2lMi/uaJxG
         v5Dbhh6YT7zWEZsrgk5o+D5HO/BTqORZIRuIiOF1wYp5AD7tu6z72pSuJoNWRTk9l3J9
         DmRyiSxwOsfaMgODlrPAqSZlvQ/JagSQz1WGZcve2irFbeHY1hBZNHX8bTDdeb4HCtYx
         DD7TUKzZP2scNcmlbbTz4t60+BTEDme0n0j1gNFdreSIN/G2QANu3Kw8WqOi9lkT9PFe
         JMaiujAx5c4uaPoMi3O10qkpQMnZGI1h8fKXAu4KLtE3hE7/QkI36gOR++2U8NEABH+o
         fANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        fh=vn3DNcL51Q4ZEzisbeKyY3eOXiDLza1oP7usxZ10N1A=;
        b=ksgh3Pw2NIkMKBsI0+loi7qYr4cAmuhe4SGh4hDIS+O9JpBRAbGUy3IRsK6JPwDbeu
         wXsc8OfO0xPI6WQjYPcaC2zDLEGx4JobbEKcT8JjeZZNmUr4FNHLB191hcUpuHxxYkOz
         w8t9aGKAaiKpn34gLczw2lEEIna9TmR+KyBUUnH735iObPbm31tvpf6uxDt2tmr117vT
         pqMhehUwV0oC9mkM9RYJfAGCT9SGhGULLmleARa3faRvTFmLRCl1nfQ+KtqOXbEk6S6z
         CTI4ySghZvH8s1y4dff8dK2O5Zlvw1Ass1fNhuQMaaEMxDRgGdjwURi6/4gimyQ4C9Wm
         pOJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624535; x=1795229335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        b=in9iqHN0nfPCFxFsQ5TcqjdklfVYchkdu8vE/r9wvX8P0g3uakMJLuxNCQFUOEQQJQ
         L0VOp/Qy2aNify/ckUxNqBQYJwG6whjmQ1tgkz4M3G9BP2xN1ChnoBEc827d8U1kYywI
         XxgPaeIDPioKzOec2Yf2Jk4FHeTbj7A1UzgCR/K9mCDWfMrmsY4V0BdLKK+L9OgbErro
         FtkLkUhPgT0DoCkemeeN4gbEy3XOko/DZB3AdRMRkoYBh0YH5IhZYljbEkem4jWJ79IX
         03c37th1nIa+D6tiVN9GakjDl0ge1Y4o8oTXRRb1Z8D20vcwHfuAPREUVz2CY+xSvU80
         D0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624535; x=1795229335;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        b=WPKc7866aWLklcMZSa1udIRsSZOS6gZ16hxPP+aWv0JILUabYHAGnYGovMa1+FvPAn
         SlNnRhvyRVrc4dZMAikrXTTBcWcLswn7NBb3nd6Hk5Mk+IwShf0qIl8Srrapz7sXoMr2
         3/b2/QVToIvDMvUjaLw2BLRxPzp66SQOEwQU6jb+dxq9BMCpRf7x8nLkwCwXO2s+RZLm
         JyrRiMc4wJdYpvnyCfyyBMCHgmKy3E75tzwpOU3Tp/gJVAqrBGF6SlyC2vEOe8avAEy3
         jQ9mGh6eYGT+X6+UPrRKXZZHX1k6oiW63JGt9qLDPOyLoJA9LfpLNoZBCpWF/DNVRHzL
         XPZQ==
X-Forwarded-Encrypted: i=1; AL+hErFjuCJoQ5ZGfSOPFRKrEiVuLJlXTR1r7rdV3xGKfoRvcswyY96hwp0B+Jk82hS7PEcAoKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0cLpSstkt6aoOOiYkt8PLjfERpR8mzdZBf46dvtaHLle6EJbO
	ivE2tlZpgunubBrUtey5NXC/BbigjGizt40HE9ZselG3kanl0G6gXS/hpB/4RzY2Njrt6o+qDXl
	gs963Yf55HlSLNVeumJFZCOjYW8jceScqdrrs
X-Gm-Gg: AYBFou09PGO5gVeYOmISK0ZxZqlV1/bS9eemDC2iHL6v1I6tgnVU6kwEdzvSV0ZJ6JQ
	QijRQfZUKGyfVbouVxuPeKtsfl9KBnSZZtPSE0ckr+W0MH3aUTUPz+qmzZZCC87lvNERz390khh
	D7zL5ZKHMfI8Nz+HhxSzBWFOODTWwLz+QYL5qcyGLBlIq1t2P8DOGs56pt0ZpLAi4EdKTJ82o+b
	b3YB2W4g1Htm6NFy9Maof60+gFb/M8SGVOUGZMtOawK+gdDsRJw95RdmbhxkzeNh2wcFOlvHD3x
	I3X3//PfiGWRmqEn9JNSH7DLFyYrQ1SxxM+xKbZCYx4ujhKOGxGztf0WYg3NCCKfd9EvmS+h9br
	fMJQiwAoS01hDNfXPfzh4CZVq75pbPuS5VfBEY7i5/zf7Z5LIUEhZZgw/Hpfcdy49M0r1bg==
X-Received: by 2002:a17:907:7b9f:b0:c46:50c6:f737 with SMTP id
 a640c23a62f3a-c50963778a5mr365074266b.31.1794624534763; Fri, 13 Nov 2026
 18:48:54 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 14 Nov 2026 02:48:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Gustavo A." <gustavogyn@gmail.com>
Date: Sat, 14 Nov 2026 02:48:53 +0000
X-Gm-Features: AclHuK-wVQEDVo4vdvK4r_U4Z-9Vz8_5cDsq9x7tFLxwC8PVNZtFxwhW28bWALU
Message-ID: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
Subject: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, gustavogyn@gmail.com
Content-Type: text/plain; charset="UTF-8"

On the affected system, GPU passthrough worked with the CachyOS 7.2.10
host kernel. After upgrading the host to 7.3, the guest still booted but
its physical display stayed grey. The exact triggering change is unknown,
so this patch has no Fixes tag.

PCI reset returns successfully while the Firmware Security Processor (FSP)
is still initializing. Restricting BAR1 to 4 KiB mappings masks the problem.
Waiting for FSP completion after reset restores normal output with stock
KVM and verified 1 GiB BAR1 mappings.

The RFC question is where this wait belongs. It currently follows
successful resets in the VFIO enable, reset ioctl, PCIe/AF FLR and hot-reset
paths. Would a PCI-core readiness check after state restoration be more
appropriate? A device-specific reset method runs before BAR and state
restoration and does not cover all bus resets. The existing reset_done
callback cannot propagate errors.

Validation:
- Local host and Linux guest: 7.3.4-1-cachyos, QEMU 11.1.3, GPU 10de:2b85.
  The physical display works with startup tracing disabled. The submitted
  readiness code adds only an IORESOURCE_UNSET guard to this tested code.
  A focused check fails without the guard and passes with it.
- Rebased onto mainline 97d73c825122 (7.4-rc2). Full W=1 builds pass with
  GCC 16.2.1 (VFIO modules, PM enabled) and Clang 23.1.5 (VFIO built in,
  PM disabled). No VFIO compiler warnings. Unrelated warnings remain.
- 79 helper checks and 51 reset-path checks pass using extracted source
  with modeled PCI, time and locking. The unpatched reset-path baseline
  fails 22 checks. The hot-reset model covers completion and unwind for
  three devices, excluding ownership validation and initial locking.
- Strict checkpatch and kernel-doc pass. Sparse 0.6.4 reports the same 17
  diagnostics on patched and unpatched code, with no added findings.

The rebased mainline kernel has not been booted. Runtime lockdep, D3/resume
and repeated hardware reset cycles remain untested. Hardware testing covers
only the device listed above.

Related FSP-ordering work:
https://lists.openwall.net/linux-kernel/2026/06/15/1402

Gustavo A. (1):
  vfio/pci: Wait for GB202 firmware initialization after reset

Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997B28D8D0
	for <kvm@vger.kernel.org>; Sat,  4 Jul 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176318; cv=pass; b=kIRmgEgvmMf+Ts95+zNwHh/TzBxAx2ojFKslTlhFUtucgxszJYiZnfLkHZy41GeuI36ut7EwaVfweaRV2eHcLt/WSunkVIFbGXt2s6PvCDg18aOZNx9ofsK+B9rCPBFycGmyjraSKUhdulLzEf5r9WSOirVyUBwVja243Opepg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176318; c=relaxed/simple;
	bh=XpQJwh2GgNhD6EAOhQ4I53c3yuO4+5Tzr8NzYHPiJFM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw1kqE6uUT10KMIGL2i8dwbdXDJOBBTu6SxXk9gELv4ij8ecw9cXZLOf4Eh2eMGNSuH7H2ORAqIKzrLC6UbESrA4Y8wZ85LSSYBDTYZZqD9QszsH/G/KBKqwCj+XORR/AQEn7/HlcYG6eeKRDpyNh3gxZSs7OP3OCot1dyd8lEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj3X2Ytv; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj3X2Ytv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso996548a12.0
        for <kvm@vger.kernel.org>; Sat, 04 Jul 2026 07:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783176317; cv=none;
        d=google.com; s=arc-20260327;
        b=jRqz8ojwet0EYPgZkOs2bTG4Xws+sa9lIyVuSyrbiMOZIRSOgnPbXa54itfG9jaZKu
         bQNXtFDBjqIj+A8AKjxtybC5V+k8mOX8OoKvp8JfMYv1dPsj5gg4e7ZdCj5FYuhDUqRZ
         6fWso5NAuLYLxKdZ2e7kpifdLbFXPPqLONvYW8zbDyWj9l2z7YVijnwPlToWhe87duQ+
         pf/HZ0wch1iRUtnvUD7Dq0MWc3M7RoBG0+sJUTVOYTQLIVcGNCTmTR9lcSgzbVRLQmuE
         URVUeT9V5LuvUQhIvauYgbSzzUwLIbTp6Ha3n6g912ZhYhitFHJ0BmHXjt7eZaaqh/5t
         ZqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        fh=Jp28J/rULgsS89ER+/zmCeG6r+EWe46ktjbMuKGCZuY=;
        b=Nb/Uuj0GaL89jgK4FDDv141hiNkgFTTh7oAOEaEbVZGR+nnNUQ3jpEsJmQGELSV1RC
         fZGFTHVE8MD9BgTwc3cLnP8Hx0za9QDdC8dXjffC5cky3wEYFBrrQj+cIkIpGGdoGWlA
         rLIdzAZ9P3vj8OTC+ZOH/S94DAoU4NJD2aKCIsFEBlU9EYwNdDbHdoG2KolDWrhyKNVa
         etS0OL7To8lVo9+iDK4ymttyMZSby8JWbtUC2homp7gfaZmPBserxo9i72+Hl8yrJ3r9
         OhycQsXzsH5bEMvNc83RONgfYrjOr8Oxs/Ge0Sm+Gd1y1RCTT06/E1oH/4w9YRvLim9q
         gjJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783176317; x=1783781117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        b=mj3X2Ytv2uJl10pzQXvHCfrL/yHbrnGjhY6os/XF5FwN/hzaL5kNUKdZynWZxTSnvr
         eeM1LDXSUlqrpEMC99soHkR07UZb51oDBHWk/xFa0kBEdHVr2HPyiKWjEWKDW2sC7yBC
         DpejwBHBsJ9cBZXT8fl+83HeVoOGC4+vUGc6ZofqpCu5Zwfyr/WzF0sk2vCr9RoGVkLa
         1CBJM6ybP1TsY2s7IPiEM3nTjpw2bXdDKsl3qw+ZIYt8ZaePulzIxDFg26MlqxO7RVD/
         oi9NVH0hxXud1laOPBTfkpiRt4xE+wRGClmPkI3cjD+GZNhJsHmZfu4zEpbYJuwajkuP
         jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783176317; x=1783781117;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        b=r95doGGXcn9yfmd4wOfP/EDf8LphB8+AtkPMEX1IKa8j2aPYfrCeNoEtndJGwcUutQ
         k3ONXvdpfZ+9NNoDNeK63FW+dcl/CLJJczbuN5+EPJjYCq1OomRFT/womZjl5HxkQVMo
         MigiTEoNQen3mPRHOz0NydsXOwDq4AekxuIbmzv0jSQU0F25bLh1wjEAP6e9D4Df2OYY
         albqFzIFqyevizNEnUd3tZ/QQZGrHoAAEefZVZkxc7G0ifL7IJXOfAfGXKw/i45w1ThN
         IOpkaCN5QLWmhhl5+YpL/BCHV6bm63BrwE+SVpk+JPRRvWRouBH8Zor9MyXx+vJ2+BqG
         ktGw==
X-Forwarded-Encrypted: i=1; AFNElJ88iurT5PYgq1odrWBTaHm7tIrFeGiPWS5jsT2ElcNJ8jsnOwD0ia/XSFOfzRuy6Jmgv4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0Ks8QOfTi9oGQtRQWHp6Bq+fWUB/W5k2HWFeXdGZGCVsbUFx
	7tXQJ2D1lx8cHzG0yilSvdA/oz2o4YcGGqe0LUFd4RXKoe5Vq65lT5iP4DcjVY3QGUWdcae7X0A
	EB1vZuQRDG+vJKKk/Sd3Oz/TIt58G8n1NExReRCse
X-Gm-Gg: AfdE7clencwcDWe/EseoIv9dLzqt78XYt0ezIzttVYfJnCRR2KLw6RKC1J/d/NDsZ0j
	BeyQTohPQwlPEM0bItPPtsjFbqCUPY83J3zLxVYQ/JQFrlINRjODhj2EXljfVHOGOnwbci/gQ2d
	Cw1ggfiYlbayeqJERDCajYXT6S9GqzCixquzVT1JMaDR8HM0G2lxMiF4SzE//a8f8WdWbjCTiM2
	STgQzSXgHZpB530u/mcgx0HyL/JcWkEplOOR5SGZa/UDDvehromSAJzcfLZKJadEGF63eLsIFKa
	DT3duegDXysohI+WW5hd+y/uJ6sV
X-Received: by 2002:a05:6a21:4516:b0:3a2:d838:bfca with SMTP id
 adf61e73a8af0-3c03e18c1a6mr3784343637.3.1783176316400; Sat, 04 Jul 2026
 07:45:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:45:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:45:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com> <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:45:15 -0700
X-Gm-Features: AVVi8CeBOQYKqHyO-ZgLrEnt9NfH2sTywpBsyBpG5p82n6nbBzKMaxoqUYDvD88
Message-ID: <CAEvNRgFL_UYz8449z-PJ2ew9x3Ju6qzaBeSxVxLkcNMJeqzMww@mail.gmail.com>
Subject: RE: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
To: "Tian, Kevin" <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, 
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Xu Yilun <yilun.xu@linux.intel.com>
>> Sent: Saturday, March 28, 2026 12:01 AM
>>
>> +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64

How about __seamcall_retry_interrupted, to emphasize that this function
retries a certain kind of seamcall?

I think resched is part of the implementation, of what's done while
retrying, which might not need to be part of the name.

No strong opinion though. Thanks for considering.

>> fn,
>> +						struct tdx_module_args *args)
>> +{
>
> 'ir' sounds redundant with the trailing 'resched'?
>
> not big deal, just a bit confusing when seeing it in IOMMU side where
> 'ir' also refers to 'interrupt remapping' and is frequently used in
> irq_remapping.c... :)

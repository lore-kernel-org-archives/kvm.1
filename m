Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499340;
	b=nbE4TGLkgUELOwf1MN2vDscvY2xuZZvb40L4/LQNL6c00gSmN92uiG1Pg5RLYCiqvvD5
	 uPbE91wWOhQihWLSnZ5dP5nZ3zTii9uwHbqtCDKWdm12shbqTjrWAifQ0vSXUJN9DVTJh
	 E2Jy51kxsNQL/vWqRmzSSOmEBKp8Obz1YxIRgDiXnsSPwZG4NXobyIRPQEsk7gMUr3boF
	 w5c0vhGcF73WbjixCRx6TLmlQfFczg0qFl9ib4LvMWCjPLqAyKzmj5LPD3GLk8MXz7yiS
	 wem84vbqBpQh+E3yGbOGedIfczVn00wd5c+ZuUGzdDZWFuzMI9eGNYpN9f2ZCFlc2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5bLIqnhjUZD53MQ8mIyoL64maRPRtf//51viUHZYxfw=;
	b=LA0mu303b4GC4GfOdy2cKuUuEpn6d44CcgfcFyL6/zhBkZd3BirKtRXTDO7+mX4TLXBf
	 4nYWDFjZhjCkIeicSb7lqVMmAg9o/x9KQZmbtgUNmuUgPbddQ6a5AwHb+41fSbOxWANBb
	 AHLpdV+FY2JMTWd7RPp66PktS+rJvgmrSVFr4g+k6XLYmg9xEy/d6Kk4hRLElmcZzLFq1
	 tfD3PfbWjd3KzP3aacQiCD/fETffX5QZ9eo/5zA6V4FIqZyc6ZoSYWYJX3XpXWRQDX1g+
	 hFwQvJX9/5VzB28J1WW634c6qB3v9HaKnII8crOAN+99cqPtP5gSQ67eC+iBE1y2Gbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=resnulli.us;
	spf=none smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YWQo69lb;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D62606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 12:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YWQo69lb
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df54150dfso2445185f8f.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1792499338; x=1793104138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bLIqnhjUZD53MQ8mIyoL64maRPRtf//51viUHZYxfw=;
        b=YWQo69lbuMlzAP5RdqrQrLx77X6LX94CycMTmUoX+vc7zIantga+lXOuVqP8Vgavii
         aMHjXJgGZcMilKGQVLQxuos2bg5NWmwNeszGgaHWYw6MOq1Wdtg/+QRSrWzrrzhTS+Ra
         S7bgQNT8g9yNBpi7b8JDzTqCzz4Avn1jbamDZDTY8/tXJ/ZaYpuSKa8eZEDVl+8+Qqmt
         ZQLt7KhOKj5xVUgPay5ZDn72g06IDDYypT7LTYrrJ5htnGnSgVHzjmkZIusiQQBJcUfS
         alOl0TJHFJO7AxJejHgBf9DgXpAIcJEmh5xR7NJHWc1kzRyQ7Jm2TxL45dPOy6Lu4mZM
         2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499338; x=1793104138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bLIqnhjUZD53MQ8mIyoL64maRPRtf//51viUHZYxfw=;
        b=2bmB0tiuse0UxoEf5f6kwG6KtUSdlOl6aUAxSZS8YPPaP4E2KgAa8pb1hpwFNd6tnZ
         bE8YFY8qTjrEbEo0UIcj1Kskw2rlHX2FEylYw3uABrqEU7ntMgy7vY+TAOYnm004eLdn
         qKYd27+R9Eh9SxhKDtghsQWdFeubdl8mgqJh7p/V5vFGowVW1p6iA1LgA2y927rlbQMJ
         xcRGMVGXUOl14oeQXBCpdOly210YBOuQGJvepx16S39VVPcetVhcyZK2MAOirUgOZRSI
         MnUfCvzhEDAkwfFZEcACWBR+uSMQ6x6wVmfWyUm5rWmlRdZW0X0y4ov2Lt5REM0fapbg
         ouaQ==
X-Forwarded-Encrypted: i=1; AKwUvByntEoK234w8+DRuq03CJrH2XVeAm6J4Mf3u8urFUJ0PYCnCrROYfPQ6MLAceuQB8ZXPm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2155WOS24OADRqnAnC8n6PadNEp1+wkMULeRxV9NPmHBZJDf9
	biGyEtHVQemZOPzptqJMms7Bc+8hX9kkOfcXaKpFwlLykXXGr8usW5KDQuhR3e31I8I=
X-Gm-Gg: AYBFou13NDt1mVfAWpkFwBGZ0M0dajtrqTDI33NNYaxxLjfDf7Vf7z8Pg0E4GwT+wJq
	/rAN2SfRxnplYPOpxhN/Cc8g06n0fF83/ICJ1OuGFZQy4bEqTwcROIflyDYd8e3IIWeaDL0LfLg
	H5/CwSINnWnUYuwiB3bPRs5M1A2ECEGmKzFmEVoYvnHPi2lNQkWL6OvDdmALPGVZPFwSHV72Kwq
	sGclJVFVNw4Y2r0Ea9oMjfqI/HT54e2ZV0eSXI20tz13BiXn4ODaWNuqXb9aJ8zFEQM/nEQZJIA
	/WbvCr5Ut8oDXObg/Z66GDYXH/FmyOc6VIklWOObX906bLA/QExUTcxK+sUrv3Lo5ylIDtbl3D7
	OC7zC8G9D4PeUpVrcd+frZ0MlO5YPKi0uqDR/WkEdDzQnBSP+kJ0iEmNKu3SvsZERR8uwiS5eJ7
	YMLVuuSrZzF/QLKX3BPxg+tiWzh+4Qhis6Jw1Wgv01JjFyxyobVZ3VcPX1vasalhbTJdY1U3fZr
	SN+
X-Received: by 2002:a05:6000:3108:b0:486:f907:ebec with SMTP id ffacd0b85a97d-48e07bc104dmr25850403f8f.31.1792499337690;
        Tue, 20 Oct 2026 05:28:57 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80fc6csm5636775f8f.14.2026.10.20.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:28:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:28:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 03/20] ctlv: Add the root family specification and
 generated files
Message-ID: <atdeH3nA_gkLwPLM@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-4-jiri@resnulli.us>
 <179245258505.58760.6060356114682279013.b4-review@b4>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179245258505.58760.6060356114682279013.b4-review@b4>

Tue, Oct 20, 2026 at 01:29:45AM +0200, jgg@nvidia.com wrote:
>> [ ... 238 lines skipped ... ]
>> --- /dev/null
>> +++ b/Documentation/ctlv/families.yaml
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +# Append-only registry of CTLV family names, indexed by family ID: the entry at
>> +# index N has family ID N, up to 65535. The root family owns ID 0 and heads the
>> +# list, and every other entry comes after the entry of the family it inherits.
>> +# An entry may be marked deprecated, but never reordered, removed, renamed or
>> +# reused, its position being its wire identity. Every entry must have a
>> +# specification in specs/<name>.yaml, and is added by the change that adds the
>> +# implementation. Fixtures under tools/ctlv/tests/ are not registered.
>> +
>> +families:
>> +  - ctlv
>
>I see where you are coming from with this, but it is going to be
>problematic from a global kernel perspective. Given CTLV is imagined
>as a general tool for any subsystem we cannot control the tree that
>things merge through. It will not be like netdev where there is one
>authoritative tree with a linear history.
>
>So if Bob and Jane maintainers both add their own subsystems by the
>time it gets to Linus the IDs will get scrambled, and bisection will
>be lost. 
>
>Either changes to this file must be strictly done in a single tree
>with shared branches (which is going to be a bit hard process wise)
>
>Or we need to put the ID #s here and have some simple process to
>coordinate them during the development process. Since new families are
>probably rare it shouldn't be a big deal

Exactly. Collision is not very likely. Explicit ID or implicit, scramble
would still happen. And in that case it is resolvable.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448444;
	b=yw2/tlDz/phycuUo1uvVCjLTlzsGJ/Vdtt31cWj3w/YLBHYLFy5vInxxcTa025TmStDz
	 bFFLqqVHV5a0NJ4GWKiBt/BRDFBAA+DMJpGngwa/H9x1AZRsS0w6h8G2qE2x+KXpjBSH+
	 VWynRrlTS48GX4EeVXwweTFelZT1HnFjCtnLdY2pMQ7zyT5jYX7xL9P+kmrFx02anlc9W
	 HROAJKtPE1x8wn5YLXX8JEYaS9lWxWQsuQ/J+YEsBOGVU/Nhla7ZwHOTSCCBF1imRRVJZ
	 JqHc3qVcrHddi2XgEC66bU8Kw+mwMCoe8OiHvpngq4fPOMqPQiGjnFdIyjEZ+jDAKwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YxzVyVE4ai8Ea+LyIq1A/L2q3uxrmhBKTxjVeIPKjac=;
	b=NvK6izAfUMFSJUfxV299v9dYcmAWykdX309K2nEjZ121XrQiCDseDNEr+DS9IhLmI5Y/
	 1a4zM/n7BHLsl2KeQkwJq4O6sNCR6fC29QGUlSl1lTm8hFxDshirlZ/jJZI0vO7eUsev1
	 BTybUhj/LA3MuElpYDjq82zkKidOP1+Yzkva/KuFcoLOjn5eqjx7RmHgKeJQLGueKcOBJ
	 hiY41eRuJKWCLg/Qtcn/qne7WA7pQnqheiC7T5wQbrIAPJ8VYE+lYFZNTwwejJPMIYxMs
	 cJUxQ5Jf8ZcPo1WgxqU78sL0HwkcXJwnPIIgKbBcRecAfJxsXNvYxNpmxxZxpUwNAlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DCWIajyU;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4C60A2631
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E4C60A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DCWIajyU
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5365d26ccbdso43397321cf.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795448443; x=1796053243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YxzVyVE4ai8Ea+LyIq1A/L2q3uxrmhBKTxjVeIPKjac=;
        b=DCWIajyUd2NrR5Rg5QH4BYrc18jOuaIFNK9krdfrMVuNBFHlfubE8POzOdp0A6zoio
         BK3Jm8Da6025c7dLknh9DJk0+VZH9DV55cQrJ8yJnUw7oCdRMpIHTUv6YgHpYHhqIori
         GGrUVou8pcQMhd9KQWvZXddio3gurupEp+aji/SeMFzVVqTC+CtP/te/WmUVmR+NlGSs
         KmBOlJCgCk0+qX6nR0Aw5RMZqvS6VBJFSdaldgcPjsZr2AoWVUN5puz1Vgd90tEBLzpY
         eAIRonSuZWxNolGYAuXxViEQpSYv2RNGlQkdAhBcBAeO1UcT99mpa3vZgxg4rC/bbjsA
         7Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448443; x=1796053243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxzVyVE4ai8Ea+LyIq1A/L2q3uxrmhBKTxjVeIPKjac=;
        b=oJ5il0N0DPo6UHxa6V4xQxEP7thxt6BC9hsJbv7hqTd84ZVmkESq6PKafJY+0fcpZM
         io+ZfxfSwkC7ITTYG12G4oVvQ7u5fUAstXLidIVidOZ7lvKfjYJj53UJegCgUNQNthnD
         Oc9HRceYIUC5/hqIFV4u54cZOaD1ZZn8LnAE9UL4LUdCG8cWFeX4J4OT5zr5IkC9T0vU
         syqoBwto3HrvfDBGTtcJHOXLeVvXmYAnLjJ4fF/BlcQCapq/tHkKjtBlZAYAu+r5ZEfH
         puZi1hAL75Dmra1sylP1VJGiQAU9/f45+pvziz+k4nYdMz05v4z3Hp+q2vMXqtFuPeb6
         fHzQ==
X-Forwarded-Encrypted: i=1; AL+hErG5Qr/6/JhZHtlfyneHRnSRHGOFDZHEQLTn9giaPwLa5FhKqtPGt4tghHqDvtfmlZ9AQlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bCmzTR85tFkIfKCooQXPWXDSdaH568iTUzQL3FsZCjz3AjNX8
	PMNmq3d8EnOGVOWzwUHZd9Y8qfIF3ARLdWDkEi/qDgKg0lhX0TzPq4tvbBoLuIOkSBo=
X-Gm-Gg: AZFdTZdLz4oNgZj36AL+D3+DB0Vs3Zaj6H0Q0HQ7zgcG9ZZOMNvAI0OxwtbWSnsbfiN
	pc1ly7rVNmVfAfkdJGiRZkwzGOp0OcKJsLQ4R0IIs8mREsYKwCuHGHNVwGfyzIWJJc0++XG+LSU
	5+1+M3PBm895aA5n+8JgS8Pjw5cL1oFitvhaVMyGjkILxg6syWcZC8JlJ4+ectOoPagtRhSUwAQ
	an4sgrScnLMvgwr7kqn28zvWIVSbPzKyyxVxUMX8XAgB+GeN0EYraBxpCszltBoRfds/CeBR8FF
	ETX6QufSSY2UvxTMpJvi/zKhpaHyVp87YBEj8f8lyo4b9sfoIpMyV1Fo3BtEDtzHYuxLF/cet4y
	WQ+45Bjpx+sTjgbbzJe/nfQmvbY645P1nAHdadsA3wI2HLnXIhuyMjesgdTqTYRWwbYRgRHaNXP
	4ma7YHl8X6UfPxwF88Jugg3oxkhwMDlUT4g8U2RXlw7zq7q6raQmyW6flqWnWMy5FfVnpJiXu37
	GZeJy9D/hzE3iZEdwsMsuwv1vHFq5IDE7VHvV4RPo7NIu5iXl6J/WqQbln+iURApVP69nvJKUSu
	ciocLKk/F/jKwUwp7i32OEBZ+GQKmhPeC68qKb1y6osg6sbZa+BoUPrzdOa75krP/uNaTJEZgrP
	YIzA=
X-Received: by 2002:ac8:570d:0:b0:55c:bc0:63cc with SMTP id d75a77b69052e-55d768a2916mr224280231cf.6.1795448443241;
        Mon, 23 Nov 2026 07:40:43 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134796329sm107324056d6.2.2026.11.23.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:40:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVW9q-00000000t9u-0g9S;
	Mon, 23 Nov 2026 11:40:42 -0400
Date: Mon, 23 Nov 2026 11:40:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com,
	zohar@linux.ibm.com, aneesh.kumar@kernel.org, dave.jiang@intel.com,
	nik.borisov@suse.com, sergii.dmytruk@3mdeb.com
Subject: Re: [PATCH RFC v2 9/9] attestation: Add the TDX family implementation
Message-ID: <20261123154042.GI179082@ziepe.ca>
References: <20261113160838.2512652-1-jiri@resnulli.us>
 <20261113160838.2512652-10-jiri@resnulli.us>
 <awQCrnD5CtEhKRWz@e129823.arm.com>
 <awQz1P6iXYrL8lv0@kernel.org>
 <20261123151128.GD179082@ziepe.ca>
 <awRYr7yB8IWj7S3G@kernel.org>
 <awRan8ZELzpTwduV@kernel.org>
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
In-Reply-To: <awRan8ZELzpTwduV@kernel.org>

On Mon, Nov 23, 2026 at 05:24:15PM +0200, Jarkko Sakkinen wrote:
> > > > As per the function, perhaps tpm2_calc_event_log_size() should be
> > > > relocated to lib and have non-TPM name like firmware_event_log_size()
> > > > or something.
> > > 
> > > Probably under drivers/attestation since that is where all the TCG
> > > formatted logs should end up. It should be 'tcg_event_log_size()' or
> > > something. Maybe a tiny module for it like we would have done in lib/
> > 
> > +1 for the name, as it is obviously more accurate prefix.
> 
> Location, I don't know. I was thinking something like "lib/tcg.c" with
> routines that are plain calculations based on TCG/TPM data.

I think we should not have new users outside attestation subsystem,
but the legacy onces will still exist obviously..

IDK either, but this is my guess..

> And perhaps for tpm_buf (both stack/heap allocatable), if Trenchboot
> ever moves forward.

DRTM users will route through attestation subsystem to do their
extends so the tpm_buf user would be the TPM driver inside
attestation. We definitely need this for ROT agility.

We should be able to build the attestation TPM driver without any
trenchboot stuff to motivate it.

Jason

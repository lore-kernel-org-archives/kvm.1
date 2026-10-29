Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266379;
	b=aj7ULta1qS53dYzjX8lndOHubw7MCXBqU/bRLsyiLaQdfaLWGnWWa9szn72FsggQjazV
	 o2Gp6xIfOc0BJ86dRnV+m62O50g+Auh8grcEZPSrInXUkIaDc+opaGqKUHsOPOmwF6ZJV
	 0R8vwCvXEtoJx+FTUkF6yYYxctMkfsxOB3KqZZVDzx0eZIeBZgUlfg57DIiu9JZoht3LW
	 l5AIpkk3Uop8wcJtyRG/vOUb0gaVWKL8eb+f+noW271qJ8JPbzOu+MWydygelgtpJJE/L
	 erWHC0rd+mMqb8ZL0Gos+R6lYAI72k7ng5u+MXNMO9gQnANlUbrrU6l8o5Hsb9dlo6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=25Xe2LGlhfjUVvHKZS8zB+EQgKUVnKIy/4iS8f7+DSY=;
	b=S5Y2qdF19b89pHQmV8HXE4tbl18zV5vV/mv5c5uCsfjYT/68yGqzRoB2CAcebLSZrLHa
	 fjbNZOzemwp04IrGLm6B7LdSLP1PvhNhcc8ibm40jKturXUxh8ksiswXhOf6V6g5vzat7
	 yPD0E6m3d9SWZOWtmpTNg/BZt/36tvrwmlALt1uV3y0oqbvGfbDLSN0FrKGdbkFuzSjp0
	 ZkrlPLDYKufSugWfGNyRS+hm97AeeLtMvL/UN1RzJIaYVORVxThqV3iJ+jmlErIvg/3la
	 p2LfWVS4NFhCM5QaR4FaptoTHJVNc8jdo0q40F3iFLMjfget+gbHoDAi3J/mli0+qmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=QH69CTU+;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D25606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D25606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=QH69CTU+
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso15518715e9.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793266377; x=1793871177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25Xe2LGlhfjUVvHKZS8zB+EQgKUVnKIy/4iS8f7+DSY=;
        b=QH69CTU+mXD9r/mvEuahgml2HOKFQRQJRW8BDZn+++9cViMZQc/pcNx8tmGqUlzfst
         VGUgif0Z8D7dZmUQqjKAyfKtT49slL0aATVCJvSp8Pah7juV8r8n2umG7Hsbtw7LWYXs
         e3Lidy6xFzE4p4IJ/Ru/yw1c4e6NtsU5b+8JxoyD6sa+3d/+tTabLmRxA/oJ9qkiL1Ir
         hP8YXvceBTsFHvjt4RNrthEjgcD61ucWib5a7uANRq+iQ6GS+WgvB3ZcOP3yzxdiOdOl
         LJph8ZfuS8zWbl59DoBWEwStQfyFGxQ/qLXI6YS4TDEaxNEqX+9iCbR8qm/HQnRzaKUm
         NX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266377; x=1793871177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25Xe2LGlhfjUVvHKZS8zB+EQgKUVnKIy/4iS8f7+DSY=;
        b=QeC1d2mbbPHEhsAji8o8ruRCdRbPt66bn2RAlCnLmKUjsqxTZLq7pyQH9d8zO6PF0g
         LOh5hAykpQn9GHt8mHs/b+Ir/NdDvB5oxysJsUtyyjhd769DL2zWf7LP2K1LRpvTXNae
         M8va+n9ZrQKlvzk7wQ7+FsR7lbxgTnMnMrZG2uGwGlwxc5YFor3HSne7nN1jouFw9snL
         E3YZtfbIBVtW2y2aApEkzpXdooEfPgdboTRA02VLLfN76N4+p2pAznExTe6/UQzvFyUb
         9XGxSXTQolsDONsuEmdSnTgU9jUeWCGeQ/RhC0Nbrb5j2QS+BJhOE4vGm+R3UypXmzg8
         9SGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH9EKcws/LhW0o1So74Q/kL9zcsv1id8nJ5O+9clrOt4im4YOSb+DFZeExOFAgoEKHcoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSzgn54kNq2nRbi6971NVaHl8vKNjkibxp2DsjGK1gG3gdI0Nr
	VfXe2hwx8ZHooti5iDbde2FqoWCdUbb201LiZIxcjerOvio40wkdmY0vTu9Xw/BdqN8=
X-Gm-Gg: AYBFou2bhDvAYS/UyfzYRcyS6UNzvbOy3wBpih+BJSK1o2UXa2M63D78PDe8Lon3kUh
	aQdT6rM+gOuTXGi+fIVLIEE29JdrHXjgLxN12+q7OB4iwbw9xe24/JUK9EOLg6FZqVLewahiqWV
	pxmTnf4LZkygb1XL/a7DbfIwPtm36LHrifYJeVw19ublPmWT601pOFO3bq4biREMPxORAtw9Xvk
	/1nn0COQ0B2MBy9IiD34d1oDW0HlG691nddNoYGMpiAkHEBxWHrq48vM58LtOnssfsewmL6Q5vr
	XcBwRyh26KCzGTyQv/DatpeyppQRQG0vfIe6mdRwVMO+Tnf7TTztiKyB+5GV7c03GJ8KDRI3HZQ
	VxOEg7xA5B8eqjk1aslOoYD7T01uoebxRUlMlwkOGzXxlRjXQ67mEoq38GtiDk2/FzLxBwseYX0
	EjZdoTLOn6GXk5UIYlUHU7R+tUgn7nEPTEZZY0irNk7+pMLCRMLP+Xt3TMljX/mVmyXTYwsZZgi
	LRC7EtjTDirs/KMCtGQBOq83jlndazXEeqTo2/6ObQc26utiT7/M2Bn4s6GqexdZpYUAtyc1yuh
	hsUHtsegyIB8LqRm2lDwXuWnyK1/+Vsii68O1A==
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr104826795e9.28.1793266376792;
        Thu, 29 Oct 2026 02:32:56 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80285b2dsm52889635e9.13.2026.10.29.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:32:56 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:32:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <auMSPNNXZv1f43v7@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>
 <20261027193629.GK1685504@ziepe.ca>
 <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>
 <20261027234658.GL1685504@ziepe.ca>
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
In-Reply-To: <20261027234658.GL1685504@ziepe.ca>

Wed, Oct 28, 2026 at 12:46:58AM +0100, jgg@ziepe.ca wrote:
>On Tue, Oct 27, 2026 at 04:09:19PM -0700, Dave Jiang wrote:
>

[..]

>
>> >> 6. tdx_attestation_test's discovery_and_construction_fields expects an
>> >>    inheritance chain of 4, but the TDX family inherits ctlv-attestation
>> >>    directly, which gives 3. In a real TDX guest it fails with
>> >>    "Expected 4 (4) == ctlv_chain_len(self->dev) (3)".
>> > 
>> > I would have naively guessed this should inherent from some SPDM family?
>> 
>> The TDX family is the TD's own attestation (TD report, Quote and RTMRs), with
>> no device or SPDM in it. In wip_attestation_all_1 it inherits ctlv-attestation
>> directly, so I think the test's 4 is what's stale. Jiri would know for sure.
>
>I think TDX report/quote/rtmrs should be a different familiy from TDX device
>assignment SPDM. They are completely different things.

correct:
1) ctlv-attestation-tdx
2) ctlv-attestation-spdm

The spdm instance is backed by particular implementation/transport.

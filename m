Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881978;
	b=eY8RfVGg8Jj1eY2ZSngMUlKPuokDPPhxfg0S62IwnNT4MUnQXrz6A0Vw4alw+Qzj8/g+
	 IETZN1VHlubTxAJE1VlLaiZrthBYuBse7OZhoKodBMMmzj5T8ZaemzP/h236ZJ5UcOf3I
	 6stLyRrs0AhTwd/RH4f17AZ6o+nkWRXLNL8qo+3s755P8ZFqPEA0CqUbvcYgW9xM2A0GK
	 Fc+BCl9VfuTJFgoB1mNFyR1S7vcTiEC1vIfKjgry3OGQ/sjSuxtRoRp0SoKhldivSRn+N
	 QZzot3qIeLJeOmRLWE3qw6jfyLezGsN3d/IP/HFSqUKizJtfzFjOD9nOwZH006nz86Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RcJPtti5GFvFEoOYZYt06D/AhFo3icPnTOuzdt+NBsE=;
	b=wmcL0BtHCiAIdYdJ7wModgc3Jnd0VfSTZMXGd73uYtIr2/suurXRUz0kAzFWAWsq+7wT
	 xlO2Q4jaS3XsxT6qLWh6kFgFR6Nf6KNwA6Y5KOQUJMJyqdzlawM9Nafaekmxbi10+FnjH
	 bU0D+qn4gwXhPcz+bSk1Olyg/qHMaIRoQXgaQleo0FopLfc8mOv1rKv1GeLRKFJMn2qZq
	 PK/DAlQuF8jAn227PFvdM0s3MxHjfTcmRFEVl+DAqkWaIe8ITxqT/QMnjQUlOjWyM1QZJ
	 Ta/3mS1tQ57734AoqUtFIgF7wvmN8ui0oV3mOeltN1MaiOI7MUdCNH30gYDNM6V9xWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626D606A331
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 12:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5626D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1036596e87.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 04:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793881975; x=1794486775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcJPtti5GFvFEoOYZYt06D/AhFo3icPnTOuzdt+NBsE=;
        b=cCtFJSjXtpRSezyNE06wb3mNCryoz4ZPMqTXXg9EyTCJZDz7c1Wwg43Xnz2iDZHF9h
         uoCWVLQ8jvnyNWaRYluSpDmCHcdouiOJqpYN9KBvHh7ma3RwL36T1cBdawdpqOMfO/a1
         D1maF55YHx7FUilZtWynmISNmN56ev+z3BACC8vviL7dY4cTVG/suNv+f41imfxIare+
         C+bWcbedtAvtUrVKoW0m4EHeVcV77/6F/wIkQEtfvtcI0MozKYY2HozTWAUqXlxvcYfr
         NNTPhbfo1Y4AwQsaGifksj17DoQg1AoaBDPOa/kjNoLrOyT0vE5GD0k95/0RPFy4NjWV
         +K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881975; x=1794486775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcJPtti5GFvFEoOYZYt06D/AhFo3icPnTOuzdt+NBsE=;
        b=l+OxOIyZ2h+azgRmbzBSEZOwcTkwaxNq+nqFjo0iZFz481kw/YRKgPeGmA+BatyCW9
         suLtJO7S8NTdialhEQpXPf+BseyYdILhmlb4tTe84o3doaYwcGxHiJ5hbKFNQOepnEv6
         BiTWR85eOLZn24DmhEnbg08kAJeZlZ2F0bTQFXT27kvGr5sCEWje4On8ZJvg6lXgF2lk
         AegOBqX6P4S1GA+Gx6xz24bSmhz1ISLecw/Q94YCzU6Pc3AMHz26KFFsvoWIhB7daN+y
         PH4b0GJUkYRwFfT/8OfzPFHentbwE52LQpl7kQhf32A2wAcrtRdtLjRI08fk3q5agh4F
         0kEQ==
X-Forwarded-Encrypted: i=1; AKwUvByNTJnba+PXTTZttBBybwXsu/qkk7Qs/PRcZdVNprAC4SYsnBq7XV63Y0P9WloQtSEhEJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C/LxddNxYIn0B019UFEErmcVeBP0PWr9h6Ui0EKmZY+7hGMpz
	WZvh47V6r/hcdxdZFtGxMDjoaOZE9rkROB1Fw7bwWp6R9Nk9e0lGg2CrYYU8slnMapI=
X-Gm-Gg: AYBFou1aRxvCo4Zz4p/mYl5EdoYX004adh7crHiK3b1wFoLJF3BAoRsFKkZhk/xei9w
	scZzKVUTAe14ZugHrcLM0EOmBcupOF/1xb04lz4XYU5N7kg3wA2IpKN2pPGg4dpBnReyC98tQ4v
	xQegXps+qiNCL4k4uNSqkVwG2bESEwaCRRfAtgf04QuMm5aPl025DCclduEXZfplz2WLkpDZwCb
	05fVLvfVlo8rx3Kn8pxrb+/V/Z2iRZVAFe2ZYTTMB7Kmt4K59nv7rTRUhCt+Oe+pxNe+bKCahSX
	ri0j0AY4TE1dkV2EgEfzytKVNrnR1C1GrBou4s/7y1evlWan2ktCh4u3C34valRZ2LqVJFRj0DO
	ak1IzP13Zb/mURBJ0BMOwJiXM5O4mDUe74NuzQq1uiLllvn/vdMeKg3cngVssaC1AuY2WbGJsTD
	lCkw0qciL3Qo3Kh7yVpi4dRnIcWLeOyZgeXnuiiYjz+IAXdveWS9/D3DEHNkry8ebn6FULB6d3F
	ulbhSFegdErzWtZQ+zW8z7qdCI3GPjwsNDWNPDvHLHpa1fJHB8Uz9/jDvgfLlkZueoJB1qyoeTQ
	lpe/QdG+4HfICCauFrNwgZESvjq2+dXA0+hHKoU=
X-Received: by 2002:a05:6512:3056:b0:5bf:b96b:2c75 with SMTP id 2adb3069b0e04-5bfd957c416mr7135190e87.37.1793881975197;
        Thu, 05 Nov 2026 04:32:55 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38ab170sm875824e87.16.2026.11.05.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:32:54 -0800 (PST)
Date: Thu, 5 Nov 2026 13:32:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 17/20] attestation: Add CTLV operation handling
Message-ID: <aux01NUd85PabtZu@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-18-jiri@resnulli.us>
 <auuDcABX27EeTApl@e129823.arm.com>
 <20261104194622.GC3889730@ziepe.ca>
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
In-Reply-To: <20261104194622.GC3889730@ziepe.ca>

Wed, Nov 04, 2026 at 08:46:22PM +0100, jgg@ziepe.ca wrote:
>On Wed, Nov 04, 2026 at 07:11:44PM +0000, Yeoreum Yun wrote:
>> [..snip..]
>> 
>> > +static int attestation_evidence_request_decode(struct attestation *att, struct ctlv_op_ctx *ctx,
>> > +					       const struct ctlv_cursor *request,
>> > +					       struct attestation_evidence_request *decoded,
>> > +					       struct attestation_evidence_object_request **objects)
>> > +{
>> > +	const struct attestation_evidence_caps *caps = att->provider->evidence_caps;
>> > +	u32 challenge_length;
>> > +
>> > +	decoded->challenge =
>> > +		ctlv_attestation_evidence_get_evidence_challenge_get(request, &challenge_length);
>> > +	decoded->challenge_length = challenge_length;
>> > +	if (challenge_length < caps->min_challenge_length ||
>> > +	    challenge_length > caps->max_challenge_length)
>> 
>> Hmm, I'm not sure whether this check is required for
>> ATTESTATION_EVIDENCE_BLOB_EVENT_LOG blob type.
>> 
>> for example, if the provider provides two evidence:
>>   - ATTESTATION_EVIDENCE_BLOB_PRIMARY (might attestation token)
>>   - ATTESTATION_EVIDENCE_BLOB_EVENT_LOG
>> 
>> might challenge is reuiqred for generating the token
>> and this would be marked at min/max_challenge_size in evidence_cap.
>> 
>> However, in case of eventlog, it wouldn't require challenge.
>> for example, TPM event log or CCEL event log.
>
>Right
>
>> Do we need some field on attestation_evidence_supported_object whether
>> it requires challenge or not and applies this sanity check per the object?
>> 
>> Otherwise, to get eventlog, it would need to send *dummy* challenge
>> always.
>
>I wonder if we should have two interfaces here for signed and unsigned
>evidence? It would be clearer for userspace then when it needs to
>provide a challenge or not.

Isn't the challenge field provided/not-provided enough?

Currently on the introspection side, device-get op would provide
challenge-lengths array:

        evidence?:
          challenge-lengths[8]:
            length?: uint(..4096)
            min-length?: uint(..4096)
            max-length?: uint(..4096)
 	  objects[16]:
            blob-class: evidence-blob-class
            max-length: uint
            blob-instance?: uint(..u32-max)

I think it would make sense to have challenge-lengths array per object:

 	  objects[16]:
            blob-class: evidence-blob-class
            max-length: uint
            blob-instance?: uint(..u32-max)
            challenge-lengths[8]:
              length?: uint(..4096)
              min-length?: uint(..4096)
              max-length?: uint(..4096)

Then the unsigned object would just simply have challenge-lengths empty?

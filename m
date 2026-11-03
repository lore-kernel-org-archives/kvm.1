Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667941;
	b=m0VehKGwZbPKFLpYm8dRLg171vOYSU2fX+1nyqK61MqpkuVGxqXPzkvFY7+6STd/D/Qy
	 tqjf9qyU/j+B03EuHlF0QpLRkCEVlspZZqAKeVjzdejOs0BVoRMorofrkAXBejH6PsLyQ
	 WBOTSy2E9TJSypcLWtI8GUknFPX0rTWkeP6sbCgAdVdo7EhwpJw7tWTaqHXvFwEzgBunK
	 gqRvYdaS2BsumBNcqWs6+4O41ruVK6HTqNm0KQ0UmqfgejNwLpwHI9lELM1BAS/7DgqHD
	 TPkrnq7ljMCnfrcfsH8iVJlkqugYfiVRXQZpXWqgRWlQ418P4k8Cl4DBsZUlUSmrURw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Qv+EdtqMB+XL1xqO+2Rl4b1uStrdgvx9BftdNrlvlQs=;
	b=1m8AMVoza54dFjFEdJN+hE5IQ8mjG7FcG/u/m9+lwiiyK934szlooMTzUROLLZJacmf8
	 ohOpP7lkvn1LvZchF51POh+dXQW9ZK4UIEdaQ/vwaA2qBGw9O+WUvj82Wq2A5d9rOWUch
	 WAAqFXPUbLkhoXu73jyyn71UNNxg5OYyfU8NAMp98+aTGGlbVnsvcdzB1Us3DNlCaH4/9
	 N1esf4jwhcBqlfR3fPNvGYooVNjrI5iPklbqTdZggbfJc20Xl2/WT1+GgtQZ12UDi4xr6
	 9MwwTIXWkkeV74mXdcLeWMpY7XdrxBuTEAi38LoVKZB7KOl4i/qNQc6Vzxt6FhT9yAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pUb0rNHx;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382C606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 01:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8382C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pUb0rNHx
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53653e30353so63242341cf.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 17:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793667939; x=1794272739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qv+EdtqMB+XL1xqO+2Rl4b1uStrdgvx9BftdNrlvlQs=;
        b=pUb0rNHxiAU+LF8DVe0ZniHMW9XjI2QNJZUDuVtuZyauhWJ9JcYl8XRJUwP1m23NN5
         YhOjwo0TjD9eLE6c+GNdgdirH4NqQys6UuF4s1ak2aBWg+qYGy0UdkpqSeNSUH+pazVY
         djyuyvx4EOAdRDVN8Xijkdq2CFi+TXuMFmjrHrjS/MOHZgGCyI+rcXQ0JE0PS/Vit8ih
         SIRs5HGehq5NrqF2hE9UIkltDBQeI+OydffKxerZZONTbpFg4+FAFMsEp59NIGXCq3aI
         XaSYJO67edsrOWUfFASBvHIFuWYkMwgs7x8IENEGhSDJcl0V26I7CvXK7rKdPcK8adU8
         26Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667939; x=1794272739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qv+EdtqMB+XL1xqO+2Rl4b1uStrdgvx9BftdNrlvlQs=;
        b=j8S7sEr9oghbaGmKBCkQxBC3ANJWA0dZeFf9iDi5TW27w9pKIzgIGXJnAMIzRunot0
         qze4y/Ry+9lYJKwUGhyF9rEcX9pCai5mLPKpb7Mwg/JSybR5+f6D5zesT1IMqAW4CoKG
         K5RvfUQlvIIo1Itp5qMrMcqpNJA100jEPOk4f0i7hdkmcKQFq+ttd+mT7E25hkbt3osI
         Jp0Ezj/rjk23RUwZKuu9juXYjZQGeIDEoWW5kg0cuzM/Mt7RJiFHL861yFIFPkzj7UqB
         v1yP2pQ5JGrBiAc9zcEe4GgoWxLUk+qYUcse26CE2gm14Qwcwo+q01ZxLZnBZmxf0PoK
         XbWg==
X-Forwarded-Encrypted: i=1; AKwUvBzgbvz+YIZTCMQDsbkBRjdiAEPO42c1AFpN0mZ1bM5rtIpJ+ayi75OeLkZEveN4ENTgdKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7BeE8DIkG2C/xaIk1Ri6SNv6DiRjI+zZwAaaA/qhe4iGaIHad
	JN53z/J3oDxeMa00QCy+R6u9frBTUQA3lCpNBHJH8zg59SZzjweqacMYZ1vqAx99QYQ=
X-Gm-Gg: AYBFou2t79X6hIl2+0LKxeGTGke4jYur/BwCu+JDpyQRGrar5+g300ld+KBExzeB+1K
	Q/hVFoI4qqXP2mNWBciVEvdP7e4tbg00xd8SGa7vx1DyhIFLsz/A/A8rKR9jxNpB/bYQAhpcGAo
	9oP1FsI/BkQyML+pz8hEKgYMMj1ygBEDN66qmOjnUSaUi8YI8Mwl363L4KRZgEhnO+NyuOlrTxK
	jNgpJcaQMHEhQ2ya52SLFbxEhBL6cTz3NE6OLb6gukd8fe6xp2TgHhQYOuHkru+A5Ky1pPiMy+x
	y3SWHaPVoQulln/4RRXqKvccc1gMCpDGhhiS5nUcxQ8bIVTxOo9fvj3/PhGAnIq4S/gbrKkl8z/
	8V+U6WXBmt/QEGojPi72/f00EmNLCwfjH/pcBAl//GyjZhe3gxi/7uPNH4Me04oS4ha6inp7CKl
	kdiVu0e+m6tcnpikWm0LoTHH3aOdvR+7Ajm+fjxgY3c8F7+U+HmAiLK1L0LJJlwngHXM4YtKEOT
	CQqul3Hn5knJQ/aBGR2rjtNHTPZShW4q7a9x8r+JlsKA8EbdGZu+oIORb1+TO5QY/NZcl/gdrr2
	37dvx/a05hvcQKtbTrBydE69Szr12/N0zhVME08W9YnLl3kH6PC46Cx8rMH6QvmwDcaYZd9S52X
	Mh5OEKHSPEA==
X-Received: by 2002:a05:622a:4017:b0:536:64f4:45e with SMTP id d75a77b69052e-542b7525e13mr187886741cf.50.1793667939125;
        Mon, 02 Nov 2026 17:05:39 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cb57669sm12221861cf.24.2026.11.02.17.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:05:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xO2y1-0000000BIml-2jCU;
	Mon, 02 Nov 2026 21:05:37 -0400
Date: Mon, 2 Nov 2026 21:05:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <20261103010537.GI3889730@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
 <auRmMPfaFINUIchi@FV6GYCPJ69>
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
In-Reply-To: <auRmMPfaFINUIchi@FV6GYCPJ69>

On Fri, Oct 30, 2026 at 10:53:11AM +0100, Jiri Pirko wrote:
> >So.. how about could we drop the sets, use a direct description of the
> >layout and do something else for the ID numbering? Maybe the numbering
> >can be solved directly by only listing the names in:
> >
> >numbering:
> >  - device-get.reply
> >  - device-get.reply.caps
> >  - device-get.caps.evidence
> >  -[..]
> >
> >?
> 
> I'm still committed to implicit numbering. For "inline records" I
> resolved it by having it encoded as a tree with 4 levels:
> 
>  63         48 47 46 45        32 31  28 27  24 23  20 19  16 15               0
> +-------------+-----+------------+------+------+------+------+------------------+
> |   family    |kind |   index    |  L1  |  L2  |  L3  |  L4  |      field       |
> +-------------+-----+------------+------+------+------+------+------------------+
>               |<------------------ record ------------------>|

Fascinating idea. Sort of like an oid

I guarentee we will run out of bits someday :) I saw recently we ran
out of bits in RDMA :\ 3 bits seems like quite a small number..

Maybe increasing op to 128 bits?

Maybe family/kind/index/field spread over the first 64 and then the
Lx's over the second?

At the very least there should be an escape hatch so that if this
becomes too small there is a way to opt into some new layout and fix
it without breaking everything.

Jason

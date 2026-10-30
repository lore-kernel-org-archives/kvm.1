Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372580;
	b=bBFlGK3CymoEVG/aPa8AtSUNLRCcafmjag8xPLI0rJWw6o4LvROYMqyPN8Kmu2qaWHms
	 ei9jqL5cETF15cypgfuBAUom0FWE3lmJ1fe2yUb4LYiW34AILKK8N7H3Y2npBSKWRBdzi
	 ZwkcAHfeNo5DCmNe1bJ5VewljPQOwJQO0VjaQPMWdddQNc8OmJ+WfLXB9D+eLaVxV24Ej
	 ajYwIzM0f5cOQsGTtHlzsYyAAe7pSbSw33rzPc8igBxqQ27kBEEf/MENLfHRpF75yI/RX
	 bHyBOVdvZrtROchw4OOU35RdoxUOFgyDpG5k7QGgLsCV4D442YALOjdWejYeQ1CzA6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LD3FTctKH+htDtI40/USwM/+YwDf042Qy6l0BgbuGzY=;
	b=vh2JvDI6fV6kb9N1KP0BYK1rHAC6GEh6QAq/yXMpJhYpioAJZ0RFMnJw4WfEAWAVCzYI
	 bm8xKzFUijGtQL4p/SUAYduLtfDByCHTQjB8LOqN6ZFk10Ow8fsf711Ryv8XMaXMwp3xn
	 MqlhRRUd+rQ/BQ0eddnxkgxAgCLp0dP9cANxr3y4d/wEo/H4zfCBQhv0caFDtQEZVySsn
	 qXX5186x1rqBRY20X8PZA2qcg6jrq6fMmCAo3TnG15Ci6AchHY9i1Jhu8xtiXpYcRBQGA
	 ofWKBJGNwluUQX0hYxv499tVtD3odpR9wRCSsl9bXUODSTzX6d1QkfbZPANrztRUYMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wwfcN5xh;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B07606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 15:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wwfcN5xh
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so6262715e9.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793372577; x=1793977377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LD3FTctKH+htDtI40/USwM/+YwDf042Qy6l0BgbuGzY=;
        b=wwfcN5xhJxmJIEs/AzLSOKGoZTkD6+8NGP2qYbyNFhJ3ZePhPC12lXgsmIHSzpBzcO
         71d0fBrr1/B0EVWRwTU4JSXXvJ/Wr1eHyWOr6vbvgmdkDIWvglRqf4i9q++G0XE3NJ8i
         S2xNR+q8cf0+NqHemf9xQpAofRPyggoeqvaCmnZTKQtViK6XnkkmWIqV5NXQQ7TxzVF2
         ZZ0TVZcs3kkfzqhYZ3v4MGg348nCq3l3bT/bwopwha2MLL2cYn1f5N9xcPZtRK96BFm0
         9J6dNo27JRTdybTsDSGt55KhTK18zZR2Ab+2mEsVjSiKfFzKHINGh8jYyPI2Ol1FvCLG
         s7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372577; x=1793977377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LD3FTctKH+htDtI40/USwM/+YwDf042Qy6l0BgbuGzY=;
        b=pre5Iji7Ogf77GDAI39zhbN2go5LTrT2yKXaRyUC9LtNbRZArJVphTFlVtv6meBpx4
         MDyG0E5tJe3vYtHStxjTpfLz462t1fyintdq+SoJu/F8ZM0nTqt1OG/XsAMZPSK9xHky
         jrYDnKhbqWvFDfwRNSsdiAz+Gg+xP0joiCFMa2xUwXpU5y0GVKjzdfAh3+phNvHAHLW3
         RFvsLlB7iSXKbXVW5ckejT1jPaCBk5xAEgpm+tkf1gqa9mPIpkH9s4hc73q53JE5WgW2
         C0EYAKaWduWIe6aO/2mp5mnYoTQT8v79ApvKXxwyYaQ/sj/60eMWy9uHPnO8qGNf/mcy
         /EEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvENrK3YifmvBcj/jnryn3b5F9191cfgKj0bAWsYJPRNdq+Amox5J19FFAGkaeKnlkKMY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJcr5DzqXw5u3A48/mb4N3d4E+YkPnSR/qicQl3N8cZgpGUpI3
	uidr0ZbS8ZfwkYZGGSKdqeAf9q24VseMb/rQWEx6iEA/VTF/Q3pRnouIp1VaulTO4DE=
X-Gm-Gg: AYBFou2UVKFxeMylos+miVQWtEgFdXCChtrIjFPuUK2W8fNrWNyFx8vsQYdEcEDYLxn
	8lPtUTXuodsiC7q7vdkY+FqdWNv5n0UvZfD0R+p+qdr2X9E+ioREPkAGo7/zeyYz0Gk89tn9ju4
	GR957cbh0dfXaSROSjipPU+Cgm8S7iEGh/j58PcpuBQ7nUCdKJyTcxUzmfyGtJrXADWJUMexHt7
	q8kWthjeIa9K2TkmgJNQ8oBsFhkb8P3UVDVr/EN+ulsoEbL68ZWWnDHZc0nZM7Pn8GuLkwLn6Su
	uzCjsb1gsSmEjMR+t8qH0QSkCpDhXbHSG8Yw1RfpViqdN5avYnQubgmVqfaY9C+aE/85JEoZ6Fx
	wOZatNfcP5zpCex2xSkdg71XVxkdAGzqylneLZ4HonGvoJ+o1YapIAn5JP4FjQ51IUwqbo+vw03
	WJpi+1VoIn/DMo/C4QtMBKDpP7vRRRVan7IF/8Q5Rp16bzkgA7l1sEX4c71uYdMJsBkkPlYIdrf
	VoZrxehUuR5Owd5Dyr4/suWJv6q7LzH5V1dXkj0y6uGVvZmzs3mm3JXQ6Q434Z3UorhwyPcMTSx
	M28be/ic2GkE0ceY0/8Unj73gjyLm/822zknoGQ4
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ac19705d57mr55863395e9.31.1793372577101;
        Fri, 30 Oct 2026 08:02:57 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm3623785f8f.36.2026.10.30.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:02:56 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:02:52 +0100
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
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <auSxhgC30bubNJpI@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
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
In-Reply-To: <179302367452.58760.3782556786585774917.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:

[..]


>> +++ b/Documentation/ctlv/abi/ctlv-attestation.yaml
>> @@ -0,0 +1,184 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +# Checked-in ABI snapshot of the ctlv-attestation family, written by
>> +# "make -C tools/ctlv abi-update".
>> +#
>> +# The checker compares this family's declarations and inherited stub fills
>> +# against this file. Updating it is how a UAPI change gets reviewed; an update
>> +# that removes or renumbers anything, narrows a bound, or makes a placement
>> +# required is an ABI break, whatever this file says afterwards.
>
>Have the generator emit a line showing the original yaml file this was
>generated from?

Okay.

[..]

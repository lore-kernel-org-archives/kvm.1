Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765242;
	b=c4LPVacgeoof3AFe/Va/OFBpB+qEc6P7yT+n2Q9YQbwMwsHlsNRMUZGpXfQqO48VcbKj
	 dcGeeL4YvW2JPpd8zDFGUsJiSlRGkQKTHXcchMsTgOFiWeFvnqhGaIYVz/qpL4EHsyfqP
	 QAg/2ZSXLTt+q9FQloojXwYWHxRu8uTZ+KeSak7fpUoPKuaYiK0A3Kt2UqCnf46kp3epA
	 ppT/ovx7ieUIZqui4EiLyiH1/+rXSTcn/T+PSkWTC6r4e5c2T4ct9hITu4F1n7hbyje5S
	 ZG/cJXGggLw4IwGLF9tQB+3wkVKNk9dyxHSsmlDjov8EKE4BhTAzO9jK111iuy6yU5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/6hrkJLl8+7F6s+nQ7oM4f8Xx3u++n7ObY70TM6xwZM=;
	b=T/mQWQxN09i9+ZQaZ+puofRFWLNhGPGvEQ0co9bkQVq3FsTHUwOwzKPkihYvvBsrkofk
	 3A4cw0or9MetOrbpjZJK7TYc/UQ2Bhw8cTm2tZp+2dH0jgfVvhoNUR3JuOugH01Z5+OGU
	 klE7dGs8faHl7FEs7bpSOtaoWLT3T3D1/HP+ksC46g7pxg3wIhehg6Aza2tDRyJ3jGBmS
	 VZCWLzMbD1NFKzKVYoY4cWzIQobIvTjsgCoawJQ4/kBW2755vVLAQevDChO12BdOXyl1P
	 64GNuom+rRpUq7edhM6jPTyoOrfYTS8UjlHO5+odnuOI6zXqbjOVcHZw9mZ4Lvu5mMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Z24Tmepm;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D7606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Z24Tmepm
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so9540071cf.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792765241; x=1793370041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6hrkJLl8+7F6s+nQ7oM4f8Xx3u++n7ObY70TM6xwZM=;
        b=Z24TmepmqvR1bRh/4zM+g2igTOR83MH9soRnIdGRSlAfFQDPUGRtFOY9hIiE///81M
         gn1/oeDUKKO5QvidSRSIWE23M60jPneoos4wvqV9I4e+WIBRQ7nZbEx3u9pGTbZ+93mo
         v29+lwhRyxercl5mWfe6Lw6ns5PNvqZ2WVy/STNJGyhe9GkO6+u43vn+OgWZlPzn7brm
         KupP7TBsEpn/837/k/d6XjDcCZUehB/rdoMXI/Bx+gclxYRi9m7A+0ETt91nuQqxDW8H
         JSf2ssQUryFdfHbm8dPWKZA9612PpU/6R+wt+M6hxFMCrJYA4E1yt1pYxw8IKTQEWl4v
         iU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765241; x=1793370041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6hrkJLl8+7F6s+nQ7oM4f8Xx3u++n7ObY70TM6xwZM=;
        b=Qj7b4jhKlGZTMfq1ZCFMEwXp5fttUkxPqRH2sf8m7wvPxwE9H57+EgljakgDAY2uk1
         huGlXKWxAvBGxiMp/GBQIpi6nL7805WZA5pPYDf7/xQCEWHi5ha8Eh+PPg+LGG3ikluu
         y0lhYqH7wuXZz6RMKwyzSk6vewIfJ524W0lAQm4caLMcpQt+lueEJW/Nu6MdbmDTHy/8
         lbNUGsyxPDiCfpgOvsnGygnmO3h+OXFjyWUZJWlWsFlnJky66m6pScwnx9I4mgFUcWDO
         NhEy+svWeOCLsmhGrAILa3E+0vwPwQ5HHfaGiryltprPMcjLpiVCP6N+BpKGeNP3eOBA
         nLvg==
X-Forwarded-Encrypted: i=1; AKwUvByPkAkla8rwKKZTfHKEsm0t8Nw64rWolMpOLiKYhSzYbt8fRcNit10TeVwj/zhopmY0lRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrLTL9YOvWyR/aPpiVNALhw6LDVsICsPnKuwZxpaxzOOvk3M7q
	0a70h9AKprwwq8bETlb6hOVGLTJYmcY87t3TjrW9QeAKacFks6oQRnw/1UA1X0rOmJA=
X-Gm-Gg: AYBFou37tSDnRDOadhtdZJFdos2IsmDEnQPzNquD/W3/pcD9tHRtDNnsFqis7wQh5NV
	8hfdxHDrTGx7tFJE5Ws6MZngLBZwtWQw7GPyqPu0tN8+lJ9cX7cGsvOfjDeiomFJ0H25j9NulkR
	+4b633emr+0VqhqEtHb4ao1Cv+cEUEOcwk1eCkyv80fazvYppizJ+RccWYmeu4sHDz8I0/Ahq5p
	nLtbsvpQZhiUbJDCzxahwxMPm1TexuHV/tmrrNpCVsf/eKCGECB8cTXuVW7taC52ERSG0CnR/hR
	OTS9M8ohVEQeSfkh7Hc83R+n02dc1cGAliQSiUC8H806Top7tVALMZHrSVOpWeqyvr/DAKC8UNG
	Wz9e9vcTuWBr/PngbC4t/FFS8j8PywVM2bGzWhEA0B2RjxhjaJHMUM/lv57aFK+1TqTiuRzb/+C
	TlhvtaYhCDz6vZhAzsHNtp2rPblZ8UQIiPM4YAo71yPpebrQ/gDI2gi73OQhBbnhvMEc8dAEkmU
	sTnKIiNy9sulpT5A5F/Tr86PEp63vC46mk3kFQtPFn9EYfGtSvfjYh4uhXkUNDEgBe5GwhfP6Qp
	PlGN77HFx0qBoPDyqGJLw+BXNOMkocy1rEDLfA==
X-Received: by 2002:a05:622a:1246:b0:533:32f3:1db9 with SMTP id d75a77b69052e-536c2696164mr33421181cf.11.1792765240843;
        Fri, 23 Oct 2026 07:20:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c1872a8fsm17665301cf.23.2026.10.23.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:20:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKG8M-0000000Gj4Z-31qZ;
	Fri, 23 Oct 2026 11:20:38 -0300
Date: Fri, 23 Oct 2026 11:20:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <20261023142038.GE3977851@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <yq5a7bjajaco.fsf@kernel.org>
 <atooh7uO2RauUTfY@FV6GYCPJ69>
 <yq5av76sj10a.fsf@kernel.org>
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
In-Reply-To: <yq5av76sj10a.fsf@kernel.org>

On Fri, Oct 23, 2026 at 01:34:53PM +0530, Aneesh Kumar K.V wrote:

> CCA currently takes the device identity index during pdev_create. I am
> investigating how to retrieve the certificate chains for all slots. For
> now, I have implemented the sequence below.

Yeah, I think the consensus at LPC was this may be a gap in CCA.

For now I can imainge CCA just doesn't let you query the certificates,
and we'd need an ECN to correct it someday once all the kernel parts
are settled.

I broadly hope we can use the software SPDM implementation to really
flesh out the uapi and make sure that everyone is happy with it. Then
we get what subset we get from the first generation of products.

Something like if userspace can't get the slot information early it
just hardwires slot 0 and goes forward.

> echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> 
> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 device-get                                                               
> # device-get, 1 fragment, generation 0                                                                                      
>   device.generation 0            
>   device.caps                                                                                                               
>     cap.evidence                                                                                                            
>       cap.min-challenge-length 0                                                                                            
>       cap.max-challenge-length 0                                                                                            
>       cap.max-total-output-length 369098752                                                                                 
>       cap.evidence-flags evidence-accept
>       cap.object                                                                                                            
>         cap.blob-class cert-chain                                                                                           
>         cap.blob-instance 0                                                                                                 
>         cap.format spdm-cert-chain
>         cap.representation raw                                                                                              
>         cap.representation tcb-digest                                                                                       
>         cap.hash-algo 4                                                                                                     
>         cap.hash-algo 5          
>         cap.hash-algo 6                                                                                                     
>         cap.max-length 16777216                                                                                             
>   device.info                                                                                                               
>     pci.name 0000:02:00.0                       
> 
> I think we can use evidence-refresh to select the blob-instance for the
> desired slot once the CCA specification supports that.

Jiri these ctlv outputs are really neat, it would be nice to include
some of them in the commit messages so people can get a sense of how
this looks without running it?

>  ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 state-get                                                                
> # state-get, 1 fragment, generation 0
>   pci.generation 0                                                                                                          
>   pci.connected 1                                                                                                           
>   pci.locked 0                                                                                                              
>   pci.accepted 0                 
>   pci.tsm-id 0                                                                                                              
>   pci.dsm 0000:02:00.0                                                                                                      
> 
> device is marked connected, but IDE is not setup as indicated by pci.accepted = 0
 
> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 evidence-get --json '{
> "evidence.challenge": "hex:", "evidence.object": [{
> "evidence.blob-class": "cert-chain", "evidence.format":
> "spdm-cert-chain", "evidence.blob-instance": 0,
> "evidence.representation": "raw", "evidence.data": { "file":
> "/tmp/cert0.bin", "data-buf-size": 16777216 } }] }'
> # evidence-get, 1 fragment, generation 0                                                                                    
>   device.generation 0                                                                                                       
>   evidence.generation 1                                                                                                     
>   evidence.object-length 1632           
> 
> 
> I added the file: attribute to verify the evidence blob's contents. ie,
> we can do:
> 
> # file cert0.bin  
> cert0.bin: Certificate, Version=3
> 
> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 evidence-accept device.generation=0 evidence.generation=1
> # acknowledged
> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 state-get
> # state-get, 1 fragment, generation 0
>   pci.generation 0
>   pci.connected 1
>   pci.locked 0
>   pci.accepted 1
>   pci.tsm-id 0
>   pci.dsm 0000:02:00.0

I believe this broadly matches what was discussed at LPC.

I really like that we can break down the steps from SPDM setup so we
can get more information to userspace to have better logging if things
go weird.

Seeing this makes me much more comfortable that CTLV is really adding
value here, these data formats are pretty complex in the end..

Thanks,
Jason

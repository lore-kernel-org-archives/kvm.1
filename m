Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755188;
	b=xr+uyyvh0DCf8QstrrbzKF2IA19Z7Y+MeAs2SCQ1P/Bbc1i3As+a/0NJI/5nrNtt7hEd
	 dgZHlATrFnOj7NkzIOQPq6pis3LXKGvJkTAKg+rbSjO5eZDbE27RZ/BJ6v0RG7TN00a/M
	 ynK9pzik0vh3glpJwhDxxwpSYsrinN61mAKjjlK3Av1oGWkks6D40WT8/SNYTreUzy3uM
	 GCwPW7OKsFGSQ81IaVAAY+JKWEbSGh9scRabN/2+CvbhhWoBwVYgW/OcaGOL671ychNFj
	 yOVMMfxiDP+9saAvwzRxXyIUBglPT/0tuJY7PbGBj7Do08ggSjXt+V2Q+cTaGIsJZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fdSFKhLyq+f/LPR+Elw+N0tvbajLhBax4+wIFI94BGw=;
	b=QN1nwn7CWccV1GX33l4U6xXW+ZFbb2yrS4+4pGfzYoEBCKKrxNsX375m+Els5TPsdijO
	 vS2H+DYGM0sfe6SejgsyUfjorANdFHfp3lM3sDT9S1fEkimsrunhRbcJcEbmtjxBJEtEB
	 p0jTudZB+r54rIFeI2d0+4s4uoRpnD+4Om0RSBBTjGOI3zEMx7QSPGNrvtUTFA/eFSlgK
	 mJ9cvR3gYySdFSutM89zARY9XYfq48gHXNgk5mWS17FLkZ1Lzd3zRDMWkHfQMK8iYfHX9
	 MqVvl++2810kdGiS9AVbaLp8C2CKhhX02VjzxCmdfYuEbHJdJ0RIPGzabIJ32EKJZvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D13606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D13606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso891989e87.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792755181; x=1793359981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdSFKhLyq+f/LPR+Elw+N0tvbajLhBax4+wIFI94BGw=;
        b=o5mqCZ00odCrExrD11a8TQy3EW58HclX7IVqpQJ0aDtWC4PHIEIWoOWOKvywUDnzAd
         DQRElDaotMo1+P0QYKFYd7s/m1DcEvsPXoKyUDjFbS67qQgaccU7N/EGQ2BCSpSiy8aP
         a6hS5FA7hu4/XfqlZBvoNYutK3cEe/AuVErU6MbQoeIRB1x1AgJsVLaFu8PPHqGRh4u+
         gpsm4WnhyiJs7FgKmNvEmjXOsa60lWScECOtP086oMSK75U/Dw1vjafZ52OVaqhQHXGM
         3vdOCLXG4w2J3qPGDr9aTud0qm6dhzAvgBDNwzKDcyit/0arZwp80ul9KDr+al2XIQVE
         sHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755181; x=1793359981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdSFKhLyq+f/LPR+Elw+N0tvbajLhBax4+wIFI94BGw=;
        b=dElkO/u2uiR3aCH8/KoUJv3jZMAZXweFV098Cg6ETv7Q84l4UjcZamH5D/+3yB0RRq
         ZSqNHmbPnBeQVro3ZJf1ZE0aNjZvadvjQqnAmivLcnCWObHsrTwa4xcRxH4IGYI8t+aN
         7DQE6OLXYUWRK8tdEVp7yZYS/AeAygCQHDnSua+79As1jCbEHSf57BmnyZDL1VmY2TMm
         ykEva13i1sKNja3RKOpPV2eAviJWCo2pcbebC3d2v0uuKausL5P85728pWLdEePxW0fg
         ZZ2phpHyb82aBooB9l2+erp3W+WHXi3ON20RRnincokvcPJyLqDS6QsuvWDoMGN0XEbM
         C/JQ==
X-Forwarded-Encrypted: i=1; AKwUvByvv/GzrfCv2LEtD8V9hu8UkvI4Cw0HZu83ucoCBWySzylJPOaFV0S960m2yv6Tq+fTZHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFlKEzzyxXuH4n4UiQ2g95SG7rfiYdqm93o/QIKpOAX65QoGvz
	ZmLBPDsbjzygqyT7nNmLV3wQM983aCiX1uXww3ba7OjLvvuEfyNfnWfHL6GUBaGHrbA=
X-Gm-Gg: AYBFou3cLmPmxyZd915XuB9ep6MuDGcwNIsNVt3NHWlYPvvJGcv40g13EhZpSV38HSS
	624bH+cibbrd77pdwWtX/3VCUfhuYGQgwOfMD7muIfOHEMhPdwgYa5k8S+RWfXECWmVUUya6Qny
	lbrRgPC3uaJKFPt1dxXSMrf3YNz1oHHplrXxFoFNF22k3IMftgaOhryWIHe/sj19k8pdjiJ5XCT
	q1+IM9+tjshdAFjgRlKcZvHGD9REtHiLNBeHKY6ch/BJYTPteOYNODnlkcee+7emW2VvsW0Wtml
	ohFRIzjFrGsRe3sSCjErWf5Um0RXbN1kuQD57fLXB8WKKWS2vGWHtV/wXx4J1jADiaHBkU7VjSx
	YQu9IwxsqdzY+s4SW0etjCKVRPTOEGmj5Q1vp36hfJdSdAH8CxzxJtK9+txw6HyXrjWtWW2uh/L
	Xg+8lgT8/L06TcX7WulYtLPy+gNgG8QmQHqoG5CJGSbqG5bVEQ/vEGD7Vd3sAIbEgs/Rmz/CbT0
	zVph3EEX+JYWrnNjVJXQFWg+3rM26Zykh7Phzf0Ucd9Eec6KNxNFKSs93fIN2Fz3s8=
X-Received: by 2002:a05:6512:3b94:b0:5bf:aee8:7b4f with SMTP id 2adb3069b0e04-5bfb0b35f08mr746484e87.27.1792755180559;
        Fri, 23 Oct 2026 04:33:00 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb02732f4sm349248e87.27.2026.10.23.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:32:58 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:32:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <atspV8U9HCw68My9@FV6GYCPJ69>
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

Fri, Oct 23, 2026 at 10:04:53AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> Thu, Oct 22, 2026 at 12:30:47PM +0200, aneesh.kumar@kernel.org wrote:
>>>Jiri Pirko <jiri@resnulli.us> writes:
>>>
>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>
>
> [ ... 67 lines skipped ... ] 
>
>>>>
>>>
>>>I am using this to understand what the IDE setup flow would look like,
>>>but it is unclear whether the connect flow belongs in an attestation
>>>framework. I understand the desire to pass the certificate slot number
>>>as part of connect, and sysfs is probably not a suitable interface for
>>>that. However, is CTLV the interface we want to use for connect?
>>
>> I was thinking about this and "connect" really does not belong in the
>> attestation CTLV (same applies to "lock"). I was thinking about some
>> parallel PCITSM CTLV instance, but that does not really click as well.
>>
>> Currently I'm thinking we can maintain existing "connect" in sysfs and
>> extend it with "lock" sysfs knob for Realm side. Both would create
>> ctlv-attestation-spdm instance. The same spdm instance may be created
>> for other non-PCI-backed device.
>>
>> The proposed host flow is:
>>
>>     sysfs connect: select tsmN and prepare the connection
>>         -> negotiate SPDM and discover certificates
>>         -> register ctlv-attestation-spdm instance in DISCOVERED state
>>
>>     SPDM_GET
>>         -> populated certificate slots and digests
>>
>>     EVIDENCE_GET(CERT_CHAIN, blob-instance=slot) /*optional*/
>>         -> retrieve candidate certificate chain for appraisal
>>
>>     SPDM_AUTHENTICATE(device-generation, spdm-slot=selected_slot)
>>         -> authenticate the selected chain
>>         -> complete backend-required session and IDE setup
>>
>>     sysfs disconnect
>>         -> remove the attestation instance
>>         -> destroy the native connection
>>
>> The slot is therefore selected after discovery, rather than supplied to
>> connect. The attestation instance represents the prepared connection; it
>> does not exist beforehand as a controller for a disconnected PCI function.
>>
>
>CCA currently takes the device identity index during pdev_create. I am
>investigating how to retrieve the certificate chains for all slots. For

Yes, that is the ordering issue. My current proposal is to perform
preliminary SPDM discovery in Linux before PDEV_CREATE:

sysfs connect
    -> preliminary SPDM negotiation and discovery
SPDM_GET
    -> report populated slots discovered using GET_DIGESTS
EVIDENCE_GET for each populated slot
    -> return its certificate chain obtained using GET_CERTIFICATE
userspace selects and approves a slot
SPDM_AUTHENTICATE(device-generation, slot)
    -> PDEV_CREATE(id_index = slot)
    -> RMM performs its own negotiation and retrieves the selected chain
    -> compare that chain with the selected discovery result
    -> SET_PUBKEY and complete SPDM authentication and IDE setup

Makes sense?


>now, I have implemented the sequence below.
>
>echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>
>./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 device-get                                                               
># device-get, 1 fragment, generation 0                                                                                      
>  device.generation 0            
>  device.caps                                                                                                               
>    cap.evidence                                                                                                            
>      cap.min-challenge-length 0                                                                                            
>      cap.max-challenge-length 0                                                                                            
>      cap.max-total-output-length 369098752                                                                                 
>      cap.evidence-flags evidence-accept
>      cap.object                                                                                                            
>        cap.blob-class cert-chain                                                                                           
>        cap.blob-instance 0                                                                                                 
>        cap.format spdm-cert-chain
>        cap.representation raw                                                                                              
>        cap.representation tcb-digest                                                                                       
>        cap.hash-algo 4                                                                                                     
>        cap.hash-algo 5          
>        cap.hash-algo 6                                                                                                     
>        cap.max-length 16777216                                                                                             
>  device.info                                                                                                               
>    pci.name 0000:02:00.0                       
>
>I think we can use evidence-refresh to select the blob-instance for the
>desired slot once the CCA specification supports that.
>
> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 state-get                                                                
># state-get, 1 fragment, generation 0
>  pci.generation 0                                                                                                          
>  pci.connected 1                                                                                                           
>  pci.locked 0                                                                                                              
>  pci.accepted 0                 
>  pci.tsm-id 0                                                                                                              
>  pci.dsm 0000:02:00.0                                                                                                      
>
>device is marked connected, but IDE is not setup as indicated by pci.accepted = 0
>
>
>./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 evidence-get --json '{
>"evidence.challenge": "hex:", "evidence.object": [{
>"evidence.blob-class": "cert-chain", "evidence.format":
>"spdm-cert-chain", "evidence.blob-instance": 0,
>"evidence.representation": "raw", "evidence.data": { "file":
>"/tmp/cert0.bin", "data-buf-size": 16777216 } }] }'
># evidence-get, 1 fragment, generation 0                                                                                    
>  device.generation 0                                                                                                       
>  evidence.generation 1                                                                                                     
>  evidence.object-length 1632           
>
>
>I added the file: attribute to verify the evidence blob's contents. ie,
>we can do:
>
># file cert0.bin  
>cert0.bin: Certificate, Version=3
>
>./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 evidence-accept device.generation=0 evidence.generation=1
># acknowledged
>./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 state-get
># state-get, 1 fragment, generation 0
>  pci.generation 0
>  pci.connected 1
>  pci.locked 0
>  pci.accepted 1
>  pci.tsm-id 0
>  pci.dsm 0000:02:00.0
>
>
>I am wondering why we need 'devsec-run' ops. Isn't that already the result of
>'evidence-accept'?

I split it into two steps to record the decision first and then trigger
RUN. But you are right: unless someone has a use case for keeping them
separate, the split is not really needed and we can combine them.


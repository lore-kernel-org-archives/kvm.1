Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956527;
	b=shAzMgufbqF8U4cZD6jci2KQvW0Dx2ouuMaHbfZT4uMFhkNatj5FwGVZXKUNUjiWvMCE
	 VgtwwkuCmRwGafVLTzK7s57x7vt7UibOWkkXlCkyOij0bdOkGOdo3wpzGungwjFkY0Nma
	 cMRNLPbHfI5e10P8IUMBRI4OZpFVNo5K6ewjkDs6sZiaKMUqPd8Oezcz1VyiFJ4pfWn5Q
	 GAZsnb0ZgL00Mq+cd9TqO7Rhsh51Y5evKP8K5pgVic1OxsMeHV5+DimY64lEGcFySqcSg
	 RTe+a8duHwxrYUJPaMRVYlk/siubGof9lRNufSspla12YZIhMX7svh5Xz6/jDIp/6aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
	b=WU7pzTwEJN2tpWM5kElkMusIykS75vC29wRDR52JubO0whDukvo4srcFf1mfR6AYjEcM
	 D1DnRJUH7lfXy2+4A2mxVXVYypQqfn6rLdW2VKKdtVIIs1B3y1k5vNTDXte57HISbLuXS
	 ulXJnhsbFw6gWOH80yHF3hGiGCZAXH2HKslNKH/+GLa/eKREorJiF3dXI7ZX6lYIHk05p
	 co2pbFYKtprzDjPhcEabMEoDS3DCk/ofBUBDmpCd5tM34VvWzVEBWudOD7OzBUJ8p4Yom
	 lSE5WCymE25javvZdaQXr5YNA+K8hrVqWKQTLRGUmBSqPT8z3or+UZOnJZfaoRoOaRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bzYymmFN;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA8606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 23:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BA8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bzYymmFN
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2efc4a84e75so9925ad.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794956526; x=1795561326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
        b=bzYymmFNaVKjp7L9MQq9R//EKsOqfeAxHD+Ud1myIbc/mUrQ6wb5lXhu3/WkgmWQn3
         EXHUPh7xD6fpYWAIw9tcXYbRSP1jKIBmu/8V9vI33uRR++ojmr3asblhLlGzBLFtyPx7
         ff2ZxZEeAB066nvX99j3cKIcpUFVReBClcK80H5KOhAG5qPc2761CNjaa/sjn4yV5WxT
         H6PDKZXK/BCoq/JmXesRCdRxLuxLd3peE2U/PoB+23vz90lcSiFVW6a70gUP4IVHz2z3
         4QlucaplFmn2oPbIs6geQaH7vQwJDNh/YVTvIpDyVHOimPH0KJ69NVyru48ymakX7UXR
         MvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956526; x=1795561326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
        b=YphxLDg6CGXl7/KKgfUnWjHgSspX7q5SMEOprFNdi7k9ySGezORYuA6KNmxx4i0atE
         f7/iPeVsD3gWVlkLdLUyGCmV88UPDUfUH7z+hXRuXMsYC0NUeUlImBhAfM68geomBQ82
         d5wtg4ZBqLwIDBQoheiNmpqJrZ0qPmdy5WNCUJshaLOiPP3tQWZ0WDcZ3vxjXwze7oma
         oc2r/sgJGIWE284P+gkwd7T7132JE5HAPgWUdYFKkscaRW0Dnf5W5SEZ54goxAloS/+I
         rkovdXvDpgqQPbjefWsPKxZJASp64irDGFp63DwZXnS1wNp8y8PNaKO1r5F3v1RHb2T8
         eiyw==
X-Forwarded-Encrypted: i=1; AL+hErH5a6mtsk6xeGOSTmbhizJVlnoY82aiucI/2SF6zMNP57UVNeHeynRm2RVl97OIO3qKCuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1wBgJdl7pm8/71maqM6zHjqPM4vpEHFRhsoE9STW2rdYQlCua
	aTtwgLLmODCdvj0ngNNwOgGd2pIdQ2U1ZI13ueBckTGBWnlP0LKiVPgrthDvpG2KVw==
X-Gm-Gg: AZFdTZfwLoAeSfZ142RPMfYSYOs1wkYSTEGeB77fzNqoiadCeLL5ujT08FLZxZNhvwT
	RGmSAFPOffnbFl/d5hvP3fRaW7KRLZX+n3zBfGZukAgrjgO/q5YS9VRoaxIIzU3h/HMRu3St3Vz
	UUChZsVgHy8B3EHGo/WHtMFHtaiWxWH1R7rDjSQUh681UNTEG/70Paad7wJn1rLYmkQTPRiqdVI
	kOKj7QR8mhOJTjtNzFk4aIsLllcAr5WCTdXHPdV91D8JZV3njVEU026IuYf1s2PIX1Pu0zXmFoX
	SPdA2onBKwIB5IUdraMHs5dMQYWQY20c9X7d3tqcB9grMS0pk11fECCFKEuzFFGTVbTOpWYcm17
	A+wFOMYhkZ6/L+FE/4cJ1WaV4ADzKJrIg3XyuBFHbKdoX1TSSNpf3Ns7T9h5Hpv3yHeVQhgQWs+
	4Zp7XzPqiUSQRrKzs2ALVmsUB3hV3ZKs+chFHsgNfPPn1j6Y25mf3vbQVis/qiLwVeSifgXl+OB
	bHNHH1lcDRo41LqGMvUOQkmrEGJseXu/vNGeACBkIMJWIprfVkafmhSMCP6zUji5RBgqGhCvwbO
	7uH7xqgizREWPIQ2OVeoSsX1tlEzQBwMWy3SvUAOmQv3fCOWOlY+kVWXF3dm38c1I1g=
X-Received: by 2002:a17:903:324e:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2eff98d2120mr941545ad.8.1794956525618;
        Tue, 17 Nov 2026 15:02:05 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac29a846sm5891026a91.9.2026.11.17.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:02:04 -0800 (PST)
Date: Tue, 17 Nov 2026 15:02:00 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <20261117225559.GB2250529.vipinsh@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
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
In-Reply-To: <an0BOyexLcOjFJw9@google.com>

On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
> > while SR-IOV is enabled.  This can not only result in an uncoordinated
> > disruption of the use of the associated VFs, but the ongoing use of and
> > access to the VF has the potential to result in machine checks.
> > 
> > This series proposes that this gap is largely an oversight of
> > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
> > violates the scope boundary of the pci_reset_function() API.
> 
> Hi Alex,
> 
> Thanks for sending out the RFC to fix this issue. I cherry-picked it
> into my environment to verify that whether it fixes the issue I was
> experiencing and it does fix it. I will continue to do more testing, but
> when you send this as a formal v1, you can add:
> 
> Tested-by: Samiullah Khawaja <skhawaja@google.com>
> Reported-by: Samiullah Khawaja <skhawaja@google.com>
> 

Hi Alex,

Is this series still on your radar for formal v1?

If this is the direction we are going in I can use it for liveupdate work
  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/

Thanks
Vipin

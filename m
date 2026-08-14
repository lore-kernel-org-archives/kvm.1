Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D640E8D7
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722858; cv=none; b=XFRPt+TxFBQzF5nl9iIAkn0qPOM/LbeTX/BrJIY/6w2bqUsA4yjKiWlpThkmV2SxtLR+53VijPPFQxDwQVwESp1PSvTA3N7LkDfO+ZATtub5jtS0YmQnw/SyUIUedn9nvapLYkoNb3tT+X+hGbxlPh0ZWvQS2ePmn1Z4Q6dXxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722858; c=relaxed/simple;
	bh=LR+F9o8z2ArdQWgZKBLhQR4M24y5KNqH0Azx9MV4D8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GomXMuLPpREvMnzKEW0BgNCPgdO3Ep9TJjlKHZMH8pnGFDbZI34PdRU1e0EJBvdLRC+NykIN6W06rSSuKabpw8Y/Sg8+deE5XHkLCj+BlG2V2r4E9pUwHbiElQek0TnD3s58rW23X8rZtNiPHZfiSfdB4/updudZtlWGn5TtlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEIVV9pU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEIVV9pU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso106695ad.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722856; x=1787327656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi8lKrsPGjtKjHhLvrK6PemQZweWipGEphM9Nz2AqhE=;
        b=YEIVV9pUPKE2x6YeYaLvUUzKEPJlO0A9rjECyiCfQMPJoR8fwZtulyUE9Uo9Lnx3yd
         f47HpH8fcQ70lGK3aizYikdheqRiCq2mOmRBlcZitRx46bXsTH+wTqYRZi5bqd8UolOL
         ic47SUWC6EZY61rIUfa8IaOyziXSsqjIXYOg/xc3k6D1pmPYKudpSCHp6Mfl34D5LUV+
         xP65EcPvW4m4teWZhDVXTfD96kZay9n61WdRRq4wPXo4xwNUFbVujkQcIR8TmnsB8Hw8
         Ux4eSjacxbqXmlxzZGa944Hp8fb/U8NIHZR8rdI8szkDp9W2jHlypfF2rRGr04g6M23n
         2nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722856; x=1787327656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi8lKrsPGjtKjHhLvrK6PemQZweWipGEphM9Nz2AqhE=;
        b=ovmZpW549oO9e0SeAZaCThgV24GpOOv6zMxcjxWDzEFnc/oHi4d0gvygndO983KS4A
         f/lj+96u3WUbwVrnGBVkGALytpkpN0a78b12BO0MXu2jwXZb29E9NihK8AHDLl3bac7r
         eT9A3/EBk4cAoiES0Z2KQGJFM68cXFajcAzNWyMZ+yIbW0cKF4ue+WgUBsCbZB2yBhhI
         NB3OETI5Xyakf+Y/nZ3c88iQDWEkzXsh73h3WxnXD9wLA4ZxwwxNls2h1Df8yXopVvX4
         OiofSflONGvq5cOpiZ8FNcz69ZGGyuNhppB97qxnfcP2cdoROLlClyjpM2py8Sl8JJfF
         VY0g==
X-Gm-Message-State: AOJu0Yxz92JuL4zxGpU/UYRBFM5DU8GMdnlrf14deSRXNyjipnbTu0xl
	qAn0MpiVUgxlResdjbOxpGxggxxnOiti9bd19VvcmaWgl0xiSKriW0omw10gC+Gr9mmJtRZgAC+
	ZiLEGLg==
X-Gm-Gg: AR+sD10cRzCKlv4oSWI8ZVKir6gINo/9U83V9ROr6ozXrX6W3XITZ9b0d4RlUTJ7xRC
	aNKl+zIkEVWzGGLO2C333S/ysCAiLZY6GivAN634am27aeCH//HZbukinJM+GGmiRPUbqCIpTGH
	E964LddBU9wamDyT2K2NWmwR0o+XYH3qJu7GvAvd6t0Gh0HI654hqW5fi7MVQUJf1JWmEbxvmLw
	TcMWhEyJ+GbMPj+sNfWm9b/JVS1GRzObkAyRcQGZQFtFJUpARCALow2f+WzXxBIqpxgPbIgP/wL
	8k4dclWG0Wa7ufi1lCepC774qnz90MPOrjf3EWIxGTmHrnZeNYsh376/0OzThsrFg0rWPb6LUAy
	knhX4wt2khss7msRj57yE8QlcyLY2wwQb4N7hHeN5FFWgo6NeXnLKAnZTTpnohKnGtWyolY/Sz5
	cJ/1EgCCvn4jITXlQ1keEWPVCxSQaCG6uR6s27otznUcSGPB1Toh0/K5DKWgWoKT0LAKaiODDIw
	acSs6O6TbUT6RoeH1NIo7yLaR8bgr9LA+IdJbyVafqZKTZ/NLGkpbiJmU8=
X-Received: by 2002:a17:902:d58f:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2d3af24fe17mr9846895ad.10.1786722855608;
        Fri, 14 Aug 2026 08:54:15 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm1779979a91.1.2026.08.14.08.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:54:14 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:54:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <an81s9PcW7OFVj8M@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814083737.66bb83fb@nvidia.com>

On Fri, Aug 14, 2026 at 08:37:37AM -0600, Alex Williamson wrote:
>On Thu, 13 Aug 2026 23:22:33 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> >

[snip]

>> >+	if (pci_num_vf(dev) > 0) {
>> >+		pci_dev_unlock(dev);
>> >+		return -ENOTTY;
>> >+	}
>>
>> I am wondering whether we should return EAGAIN from here, since this
>> function is used by vfio_pci_core_enable() during open and it doesn't
>> fail the open on ENOTTY. Basically whether we should allow the user to
>> reopen the device if the reset was skipped previously? In the previous
>> instance of open, the device was setup with vfio/iommufd and the vfio fd
>> was abruptly closed and the reset was skipped. But the device went back
>> to the IOMMU default domain and that is probably an Identity domain. If
>> we allow the device to be opened and re-enable busmaster without a
>> reset, is there a chance that device would continue to DMA based on its
>> previous setup/context? Probably unlikely?
>>
>> Note this is different from the current vfio-pci behaviour where device
>> is always reset during close.
>>
>> Maybe thinking with too much paranoia about it :D.
>
>Devices are only ever opened into a user owned domain, the IOMMU
>context switch happens before this and regardless of the reset.  Close
>also disables bus-master regardless of reset, so there's no risk of

Yes the close side makes sense, I was more concerned about the reopen.
>ongoing DMA if the device is placed into an identity domain between
>close and re-open.
>
>Actually, I think -ENOTTY is a leftover from a previous iteration where
>this test was pushed into the individual reset methods.  -ENOTTY allows
>continuing to the next reset method.  With the test guarding all the
>reset methods in this version, we should probably use -EBUSY.  -EAGAIN
>would conflate the try-lock contention error, which is actually a usage
>race, versus the PF is not in a state to handle the request.

This sounds good to me.
>
>If the user owns the PF, as evidenced by them being able to get to
>vfio_pci_core_enable(), and reset is blocked by the SR-IOV state of the
>PF, I think there are arguments both that the user implicitly opted in
>to the best-effort reset, as well as a use case that allows the PF
>driver to fail and re-open the PF demands this behavior.

That is fair.

Thanks for clarifying.

Sami

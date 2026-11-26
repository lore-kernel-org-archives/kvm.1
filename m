Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706096;
	b=1v8sCduDgkuwF/wyWQoi5wzw8Qdpl98AEQxxbwAFd8F82swnPse83G9E+TyPx++7w2TO
	 hdsSETGmUQRY6UZvJ1o19WDvetKbTuf2CVWLsf7mS/sNPqOQzdeYenCIjMOoDUP+hsfO0
	 Pb+gE7leDiskjJ7qc/41ntKWR8AU8QRd/dx7QoPa2GS0XZSODZ0x3lU0H2eJtTGXJ5AOf
	 iHB6XwHA6aM1BweL656FU9qSrve240YTE90B1JXG7Z9Eo1V/2YvO4m98RjReULPxlFgE6
	 GKcmHGA7SRIeZCb/zCZ5kXqngyq/V/ItVRJBKKzEG/9T6GDPXqAKgcwlqU7CjUexd7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
	b=mR4OPozncJSPsRx3tYgMBIPwEkq5ZlWgLyGFyZAUjpGilGmmgAP77SQyYO5tqV51xjvY
	 0LQ7Is/qaxZ/ZV4/w6WnDts7C4Zhs7LpFyMCQQCrx6JIc6SG8JUI3HLKixj23w1kFASKW
	 j2X/bSjhFO5kg1jM/0xpY0sEa8vviGI8luoIy94nQDU8s1+bZSktBA3lnWL6KwSCThNFv
	 q06j2gTSUsgrHi/WMow72qMS6bG/kdvbobK3aowyHoYS0U8rz+LVnMRuwcHo7LWWTnWqm
	 COlcxKkwLwYwGr6rAEzn3pMcoR4wquX7pTUh6SHrMdY6zlTBS+JFRYlUn0hnLtgfMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA1606A326
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99c042cee7dso3735350241.1
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795706090; x=1796310890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
        b=at0tl1DT2mSnZt3nOLv37aifBxhKmP5gZR6l3IcV6A0l4PNDh1smzHC9LCyznNI0xy
         0790xp6rnZ5zk9V9cyzVx2d/FiSPTTVDaIIPdQL2rooFjqMCzmjpZ/i1ORZu5558c9bl
         vh/VpnMyCZ31i+zeKTRTcR1BG6HzEIngJxPY7adqL+BVSJbErHzd+cKh94xjTC8XMCkw
         Jkxvk3KYom48V/7Dw4RTi5/jCmYmQs7D+pcov3weNXk1MGV/PpD+BIurNiJ55Gencezo
         cbUYkldLl52PD8TwtiRrWWLsxqW3+fFC/BbMUuEtJiXgF/YnAAkH+oEXGnNgTG00E70x
         EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706090; x=1796310890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
        b=XpdNJ9bC31Fcv7+G5/F5OalfgP076I0USKub9PwSpaRZyywaqeHwWGsUJbLULn2ZYs
         mO4cp9h7okV5yJ1ZxKBujxp20oc24PLDvuOEFV3gO7xVUE7/3yufvuWcWgtaTfkxVUT5
         fJPb5rFFGbtZY4TN4pQR0YfzBKBZXO+CmxT0qJ3Q9Vn8M8YI+BeamGHor5JY0pnD2rHe
         jAEKWt/y1cDbSMSBbnLu6j4CSrJ2h0R1NOb4WHEllkip74aqDL5hH1FSCNi9EKko4otK
         BRFofCHmwANbz8lTLEFJKa+F4u3oM2h/dDx1TcMHLljig+wL9Vs0B9kBLuuPIWjwW5/P
         CU3Q==
X-Forwarded-Encrypted: i=1; AL+hErG3yQle/skuLNHBmRpDFSNDaxZuOqL8ILDgSOziCqDmP4qKh4asuFprD0+z148jJ2n8Ku8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aOH7VKI6ac+QSQSI1EWfpYm/NRtuRn3uSDWg5U8fZCXCVxJaT
	muTRBVdy4Xd6a+SQAPbFmFkAFNeh/5daryjh3lY8HChjuYYaFaa5AymfDU7kWkHqfEU=
X-Gm-Gg: AZFdTZdQcE4hxmQHXf18A19PdEC8eidbTe1gaDak1YM6p5eafEWR7ij2E9PlUS2eTjx
	FwXEhA/IBY/duVcMQ/xRgpunk2I2ez7T2M4xm7zfnHS9rPsgiOMV9QMYXRV/9qA8olCwgwwqN7B
	EkaiUbfRMzyVZWfj4UsHWcMOBw2ltBZljPsDvlWKkWJ6n/fVVqDBcpkD9rsm+VhFNwLHPoynR5d
	qhlni85MSrdXu4XbxUhU504pC7p3CkYBW6ve8utqXM6bANSlxmRHgqVFZN0V2cLxLSpWiUR+3Dm
	/UYGbfzGVmuhREARYydkyhX2Rq8L7K7npx8r+rDQwskcOaBI191BelvFMYiiyB0fdHFaa4v7l2L
	P4/Fg2GOdRJIZpMQnPZHjMplXP368/v3KKR1do6UtOhfgjNHJmmgWw+38HQXqmqu6MgDbxnOpOi
	MmksY7fQerWbKptattn5n7iKY8NAMTzRY8Hnlxl6/vKSuG34sFlDvqpv934NdhKlfIze154IIQF
	cd8LOMi38B87RsSNjVLPj7tFaP3CwgN7KdJKZcJJTN2CfZO3FIqJtkusOT1rGrwrj5dI7cQBOX4
	cmTXy9M=
X-Received: by 2002:a05:6102:84c8:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7d71e329ce9mr10299312137.0.1795706089640;
        Thu, 26 Nov 2026 07:14:49 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm193141456d6.17.2026.11.26.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:14:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWbBQ-00000004NdO-2PDc;
	Thu, 26 Nov 2026 11:14:48 -0400
Date: Thu, 26 Nov 2026 11:14:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 04/10] PCI/TSM: Defer TSM vDEVICE allocation until
 device setup completes
Message-ID: <20261126151448.GO246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-5-aneesh.kumar@kernel.org>
 <5e04323f-dfdc-4956-acee-bcc09926726d@amd.com>
 <yq5aqzg99uio.fsf@kernel.org>
 <20261125141947.GD246011@ziepe.ca>
 <yq5ald6gul7q.fsf@kernel.org>
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
In-Reply-To: <yq5ald6gul7q.fsf@kernel.org>

On Thu, Nov 26, 2026 at 12:34:57PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Nov 25, 2026 at 02:07:19PM +0530, Aneesh Kumar K.V wrote:
> >
> >> That is what this patch does. If IDE setup is not complete but the
> >> device already has tsm0 attached and connected, pci_tsm_context_get()
> >> returns an error from cca_vdevice_init(), preventing the device from
> >> being assigned to the VM.
> >
> > If the device has not been fully accepted on the SPDM side then you
> > should not be able to create an iommufd vdevice for it, nothing else.
> 
> That is what this patch does.

Well, it doesn't exactly. It adds some code without any users and
doesn't explain why we need to export a lock or add more core code for
this activity.

Nor does any of the naming imply it is only to be used for iommufd
vdevices.

It is problematic to be hacking the core code without any drivers, I
know we are kind of stuck with this, but lets try to limit changes to
supporting stuff that is potentially about to be merged. viommu is
fairly down the road still due to all the dependencies.

Jason

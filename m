Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511756;
	b=iLc/IazDyI6X3u6LZ4do1cAA3F8ekWQt8x0MOOl3+Hu58hJS1NLyIOTI7yJX5z8RicPq
	 OoTEfO7KuPssfs35m72On+3vqxRCpaZ/6HRPsLYXBNbjOje1E2ETh6TIN+4HdH4y/rhJX
	 u2EgIAjsLF7UnXSmJtcaLgmeiQyxKhGv2m8RrjoxgcZXEsD7TmrNri25pSBA2ZNB2wg1k
	 QDA8D7rnH3Hukd1YS1VrqDaWIcTaaY88he9cAaiOCjN/xk6Q+CohSBhuy51ghoVuv7Fku
	 4gM3xVRJ1QAGoFkk/rknS70UggK3+gRGh0D4/VFbwx6EWAOkG2ZpwWLZ45GZQaR0eiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511756;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Sm8fHDamcBdzMl5gH1h8FKaHDH8UrW+Ey8qPWPBjzGw=;
	b=Jfe5NwBqGmpsrcObH00yRfS3wqpz52vO4T1240pteyMcWoYsaBCw91io4zjbxHREpGSG
	 +8JBoP0TggF/cjjb9yAVPExiHt5H4jvb8ANOSacBJBbXC/7RmFQnf5aXoCo3GjdOsG3Jm
	 h31mjVQZyiAu38p9GS34+B93NImWck0iBR3MqA+xj5mny/visUIw5K+Gb4EZ99ImuAaJN
	 eHvwpw/MalajTv/WVSqgCzL/rbDv76yaXW22HTEukEXReGeUCWmCLdvZPBhb0yIouH1Ze
	 NFhk48JtC7tIqpjkhbH9hfpACj0gyILPOMku9arUM17x1Ds8r/cqW18oRId87plXS6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X4lGo9CE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A6606A324;
	Tue, 20 Oct 2026 15:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1A6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X4lGo9CE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB36916F8;
	Tue, 20 Oct 2026 08:55:50 -0700 (PDT)
Received: from [10.0.137.15] (XHFQ2J9959-5.cambridge.arm.com [10.0.137.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16E3D3F7B4;
	Tue, 20 Oct 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792511754; bh=RA7wOkYKzBDqak619Rsj+v/XerrUB1e1xwduoqIgrN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4lGo9CEziSLBpzJ/wESFC5gv5b77FuUDrR0qNwD8V1L1mSKpYmzGUiAukpnL80d8
	 P11iPoiXfYQuXADVOOxE6uyuYgs13RlDvy1BObGmrYbA1li5ZIbGLrEXmg2JIdJMIw
	 rykl0k838v9Jemvp9bv+0a2Q8qDWplu00g6B3roE=
Message-ID: <3f49b39e-139f-45da-b646-dbb240b31776@arm.com>
Date: Tue, 20 Oct 2026 16:55:49 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/15] vfio: Support VFIO devices that access the
 CPU MMU
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-13-ryan.roberts@arm.com>
 <20261015164421.GD13920@nvidia.com>
 <95e0f9bd-0203-4c7a-9d09-622593bb3d4c@arm.com>
 <20261020140944.GA3008132@nvidia.com>
 <c367caf3-d462-42ea-b482-bf9c51c47a63@arm.com>
 <20261020091323.3c51258e@shazbot.org>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261020091323.3c51258e@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2026 16:13, Alex Williamson wrote:
> On Tue, 20 Oct 2026 16:06:37 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> On 20/10/2026 15:09, Jason Gunthorpe wrote:
>>> On Tue, Oct 20, 2026 at 12:51:26PM +0100, Ryan Roberts wrote:  
>>>>> However.. you still have to affirm which single mm is the mm that the
>>>>> device is going to be doing DMA against. The process the opens the fd
>>>>> should not be forced to be the mm that it gets linked to.  
>>>>
>>>> What is the mm representing here? Ultimately we want to install the KVM
>>>> instance's stage2 pgtables and (pinned) VMID. We currently get that via the
>>>> bound KVM instance (which looks like it still works using the cdev interface?)
>>>>
>>>> The guest will then install the stage1 pgtables and (pinned) ASID associated
>>>> with the relevant (guest) mm_struct.
>>>>
>>>> Do we _need_ an mm association in the host?  
>>>
>>> Ah.. I see, I didn't quite follow that. OK.. Ah everyone else doing
>>> this is using iommufd with a viommu to establish their connection
>>> between device an KVM. eg Jacob Pan's series. That's a probably a
>>> better idea to stay aligned with the common path. Though your reasons
>>> are a little different..  
>>
>> Just to check, you're referring to [1]?
>>
>> I was under the impression that I could open the VFIO device through the cdev
>> interface, then bind it to the KVM instance via KVM_DEV_VFIO_FILE_ADD... Why do
>> I need an iommufd at all?
> 
> The cdev is not unlocked to actually access the device until it's bound
> to iommufd.  Thanks,

Ahh - got it! Thanks!

> 
> Alex


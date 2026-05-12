Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78273E173F;
	Tue, 12 May 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592443; cv=none; b=uIKvDbNl+m2iyfb5KQ9kuEvm7F90vVJz+OnRH8w5ztv3FoAFlmwdryXpqQJnBlCuLg3ZK/F9IacKTYrRnbZru5atGbClz3v5ZS7PP2BxH8ypPwg9ZP4YLveyPTLbeQiG0F18CC30lmz1ZCMDAzOjg1gxxSU5YoGJF5dpKfN/1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592443; c=relaxed/simple;
	bh=KhZQG/TG9b51So0M1chQlw8ji5cVwhSFfSrjlk4m7Vc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oEm4tlUgKkUDYVVoI3U8/xwooKSyLG+7RxEa3XVuqipf1aUIv0rGno8gZRkDFpB2O+FXwZRkovFiQ/PYIz7UWCp/nKPq5gRCIeK1ClmSJolFzYJLuRVUSxwDtwHD0qovT488g+zVE2JEchNIC+1eqAFftpyT9uTq6T88/A1cXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=tRgvcsSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7ge6P7M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="tRgvcsSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7ge6P7M"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCBF91400075;
	Tue, 12 May 2026 09:27:19 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Tue, 12 May 2026 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778592439;
	 x=1778678839; bh=X1abo4gTth+TY7fuw7wYWHFpeyT2u1LehVqj4baMXVQ=; b=
	tRgvcsSyl+5DSEeFj3bT80ZmE3xnQW35qQFr06Z0HNTL68OqVeixL3XNI6Or4gtB
	mfCSIamNF8ybPsSOaUkV9VQsDjb7o9fB6JUzzK6ABWtR+x1XdLUE0tVneUeNF2/v
	GpZlgtsE7zGEMPsyvFbIIstzh+d73dOmNXkmmwRoF0sCvkuF3To/HdXsF91zSvqi
	+sBboSxkFSqzF7zpcixHt1mAbA+mW0ftmqRLvgLIbKFdMAw6ZU3uro+u1uieEhHU
	kIgOg7CRK2tJE9gy3b8FTejbrS5PT5aQ8lS3YRu8QjG8+HRnu8bcBR0PipKeaQ+A
	HD7VhVyHlGkJU5+6Lz4BMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778592439; x=
	1778678839; bh=X1abo4gTth+TY7fuw7wYWHFpeyT2u1LehVqj4baMXVQ=; b=G
	7ge6P7MH9Wxg3+KC9+SF/9c7PXLXHHjJZNPB6UsJNgzKLJw8TdrIYk6+jmWiJP8f
	P8OVr6M5QB4aAeBA1ftFealr7tQsgLjJTHW52A1JML59jvL/FMflIUJZDrZBZxrU
	l7wfuQMJB/6/poQ47ODXS7Q1TxRQb6Oe69bVXeaO2Gk1o0B3+ofgfFCr8IZ32J9H
	QMhqQ77xzpqSSQBcQF4uWED+0umYChoLgnyjQ2/ZEgt3fIuLvWM/PH9KBknCg+Bs
	QrqnD8SIt24Jma/hGBPq+NWedFEJeWGaSTT7XBBSl+pkc6xsHlAzPyQoLkAsGRmf
	XsC/Qxo+EYsdnTAGPZ3iQ==
X-ME-Sender: <xms:tyoDas8d0R5bKjfPfudkZoM607wqGupbMCSNlovPO0uuxkBjrEuPZQ>
    <xme:tyoDavh-NNjfJ9kfA-PRQlm2MC-cLZdYs3i2vnxosV6bLqPaLa6y3nzL5cz_JlGZt
    2ri4eVa8rCx4SQZXxxJnzPXEFR7QFOnJzQoiwX-3IqUNbygJKaGTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlvgig
    ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpefgfeeflefggfffveffteetiedvtedtgfdvieevfeejfeefffevteej
    tedufffgveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    eprghlvgigrdifihhllhhirghmshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
    jhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohephihishhhrghihhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tyoDau_V4NQ_Fug_Ll9rZDoLRiChj_ujKMJxsCiseMEZNkKnPmTeIg>
    <xmx:tyoDarS3D5YtH_8S_gRMDYz0r-OYVjAcEJWxMFRmG9brISnITsJmiw>
    <xmx:tyoDaocoU-l8bpJS6RWmtNXCDPYLQ0FyxXFgSLckzyal_pXqEI-ZEg>
    <xmx:tyoDatSMuq18wh5Xuwif-v0ty05c5UM_ADa6iDSmCnfIDNr448Qnjw>
    <xmx:tyoDamPX8HeXUDI7A0QaYnsS1jOmOIRMw7-TIazXSLwkWP5OYmBcIMQk>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8AEC815C008C; Tue, 12 May 2026 09:27:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQqULctSpKhZ
Date: Tue, 12 May 2026 07:26:59 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "David Laight" <david.laight.linux@gmail.com>,
 "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Kevin Tian" <kevin.tian@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Yishai Hadas" <yishaih@nvidia.com>,
 "Raghavendra Rao Ananta" <rananta@google.com>, stable@vger.kernel.org
Message-Id: <fe3caa16-ebac-402e-9010-5fe0c73dbff2@app.fastmail.com>
In-Reply-To: <20260512141711.70c49471@pumpkin>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
 <20260511221609.3837652-2-alex.williamson@nvidia.com>
 <20260512141711.70c49471@pumpkin>
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 12, 2026, at 7:17 AM, David Laight wrote:
> On Mon, 11 May 2026 16:16:02 -0600
> Alex Williamson <alex.williamson@nvidia.com> wrote:
>
>> Bitfield operations are not atomic, they use a read-modify-write
>> pattern, therefore we should be careful not to pack bitfields that
>> can be concurrently updated into the same storage unit.
>> 
>> The split fields (virq_disabled, bardirty, pm_intx_masked,
>> pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
>> contexts that don't serialize against the other writers in the same
>> storage unit, so a bitfield RMW could drop an adjacent field's
>> update.  The remaining bitfields are touched only during probe or
>> close where no concurrent writer exists, so they stay packed.
>> 
>> While reordering, place virq_disabled and bardirty earlier to fill
>> an existing alignment hole.
>> 
>> Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>> ---
>>  include/linux/vfio_pci_core.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 2ebba746c18f..24e8db5b1c0d 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -101,6 +101,8 @@ struct vfio_pci_core_device {
>>  	const struct vfio_pci_device_ops *pci_ops;
>>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
>> +	bool			virq_disabled;
>> +	bool			bardirty;
>
> I'd put those two after the :1 fields to avoid an extra hole.

This actually fills a hole

#define PCI_STD_NUM_BARS        6       /* Number of standard BARs */

6 bytes above, pointers below.  Thanks,

Alex

>>  	u8			*pci_config_map;
>>  	u8			*vconfig;
>>  	struct perm_bits	*msi_perm;
>> @@ -117,16 +119,14 @@ struct vfio_pci_core_device {
>>  	u32			rbar[7];
>>  	bool			has_dyn_msix:1;
>>  	bool			pci_2_3:1;
>> -	bool			virq_disabled:1;
>>  	bool			reset_works:1;
>>  	bool			extended_caps:1;
>> -	bool			bardirty:1;
>>  	bool			has_vga:1;
>>  	bool			needs_reset:1;
>>  	bool			nointx:1;
>>  	bool			needs_pm_restore:1;
>> -	bool			pm_intx_masked:1;
>> -	bool			pm_runtime_engaged:1;
>> +	bool			pm_intx_masked;
>> +	bool			pm_runtime_engaged;
>>  	struct pci_saved_state	*pci_saved_state;
>>  	struct pci_saved_state	*pm_save;
>>  	int			ioeventfds_nr;

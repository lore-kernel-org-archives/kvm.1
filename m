Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9833C1F51
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072577; cv=none; b=kQccecJJDi9ovxuZvZ7kmXt3bAv+leSDH3SCXSB8GH0KyL2869TCDqykticTxRQm0qE8rKKqjVLGykGsVrftpEF8okxlPBRbX3pQwXaLbwT1XfL6mftiiHrphKsEY6FcIuZO816jf8HlfY/iHZEl3qyVS2uTe0+rBDXMwG9PCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072577; c=relaxed/simple;
	bh=1s4jCvq8oe7L8zTPt/8najNSgGP1x7KJi9la/FnhfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajhvZB7Rr1CZj+9UtvKOYCi7ilfodeJAOb69XsUWNVU9ylwlSTgD9M+h3OCbrw9OluZDbTZCLpXkgejgp9MNare9SY8C2Vmsa6IdbJgrgx46C4jG6rnw9cv9K4EtFX51l301jZqHMhGIKoWCxoI9Jt49IYZuVmzgGYG6bFOQ80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fq97Mw/Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fq97Mw/Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2d865383so295ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780072576; x=1780677376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hkl9oyaLQGMd1OIG8CqahDq2VdYTq3MPtBcULn0MWsI=;
        b=fq97Mw/Zj9wSbQOXjU9CGa3kn5gbOg6pz4vkhr9VgF0RjhGlJObe3VOinUhA3GzAYA
         RXrLsJjH/1JXqghXCDNesrVRFTT9Y9gaq2rLpZK2IUwuSEq4rSSvC4Eo5/ardhtVED7f
         JL7BQnN+9m0REtRILhnO+Jf1BOa+p6CaNplYFRdpJ7u3TIFifRRjfV1VHr0gQ9fuimdW
         dhUfGbbfzyK2WTcCLWGu0ehrgHOnavpIg4+CmDpm548utxtsSf9OUVrTgNWnldfRvt2A
         UvNiwgyJQA1Zv1zVE2QeAz4/NycUH8X3XtRj3WCT5NFyCXkvq8KE1OPFg7ZgLdauaqRE
         Mw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780072576; x=1780677376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkl9oyaLQGMd1OIG8CqahDq2VdYTq3MPtBcULn0MWsI=;
        b=HyNJaNKWj18vI5s+u89YWxLxWzfIMhlEMT+GFG0zREnOWLXA4xnobJC41g+TpZb0wz
         tB6na9cyvRCEqJyqBISb6aV/dIJns64rTDojL/ZNgOuKcyD1cACf5TCtcS+0vaZcXGiW
         g3jPVUMPh1nGZQv+6L7YkJfHjnuNQRwRwb3aOwDuy617lSsgaXm4+2cMvO6lnX+nEGEb
         mhdtqfeeFYW5Frpc8PjsVYd12ZfxmutRTeI9QBQZU+dZuYvn9NnV/vbBgU2yltHF2t24
         pttuOCEL480cUazh88m6HJu+7rse7vTJo3PtzV/ecXEv+L0Z31Kq8IYcT2bBSdyJhIXW
         eKUg==
X-Forwarded-Encrypted: i=1; AFNElJ/WmM6brdtemu1kVF61swObaHFvflXwFKSFgWu7Wrci6TCfXSwGCiDoMrfj4ncXy2Bv848=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYEDNPRjHZl6rbdJyFt2WirQHpM2+/araQwM4ZT9aKSoZyXK0
	V9Y8BX/fmDUT2gANvoYvPoe6La2FDTnsl1w1671rvs1qACNa+Bqmph6nqX8a88FYbA==
X-Gm-Gg: Acq92OFleA/cnM7ni9HVd604ELVkX3dQlU6tkqipby/CMU1yxKcTtKdTRRJHeN2g/V3
	4OhheYuzPCvmu6X8J+66Qdg1apG44Sy7c3109W3p8QYpJnoP27uW9MtXjnKOClEtIqxNLl8zzon
	lQY/VmmmYUur49lwkGb0Qzf1es5xtT0Ss0Bgj6IkTMyphT5K76dTmxHB/UAlJzLeZtaa0S3TY6U
	KGfRONZy6jHDGVOlEZa7IfXgJacAZ1pnxWvm3d746COYT6KRHTFVhdDcDagDk2ZDSq0Zuhi2qer
	gG7sY2a/Rsid/JaU7ZpLJtTFl6bP2bFaiNo5Zd2ht0jvaf9aQ1EzrLROw8NfxcCQ2bzekrmhiPR
	0dn6Bq/OwAwFN+0qX+Oy6+6ZQWNSiJHbupuJIL9f7dQniLgFPM+kYFN6Ctl0vl3xsYKH3hWTAuT
	xm6OOzOXnYYoR046w2doZgCR+MlvAAbmkzsfATDJAHmPK2D6H1fWJHiuBHZw5AqVFT6LArPw==
X-Received: by 2002:a17:902:ce92:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2bf22eb614amr2015775ad.11.1780072574937;
        Fri, 29 May 2026 09:36:14 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5d83sm26696345ad.8.2026.05.29.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:36:14 -0700 (PDT)
Date: Fri, 29 May 2026 16:36:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <ahm_DQDCEMAIhSDu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
 <agr6yoyYYq2QFxjL@google.com>
 <agth8vZh96TfEYl_@google.com>
 <qlvj2ljrlj6vlbto6dyqkdofrklhb7erjex7xg7ei5jils5mx5@7hqisoqevqfi>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qlvj2ljrlj6vlbto6dyqkdofrklhb7erjex7xg7ei5jils5mx5@7hqisoqevqfi>

On Fri, May 29, 2026 at 04:12:20PM +0000, Ankit Soni wrote:
>On Mon, May 18, 2026 at 07:08:01PM +0000, Samiullah Khawaja wrote:
>> On Mon, May 18, 2026 at 11:40:58AM +0000, Pranjal Shrivastava wrote:
>> > On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
>> > > From: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > >
>> > > The core liveupdate mechanism allows userspace to preserve file
>> > > descriptors. However, kernel subsystems often manage struct file
>> > > objects directly and need to participate in the preservation process
>> > > programmatically without relying solely on userspace interaction.
>> > >
>> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >
>
>[..]
>
>> > > + *
>> > > + * Context: It must be called with session mutex acquired of a restored session.
>> > > + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> > > + *         found, or any other negative errno on failure.
>> > > + */
>> > > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> > > +				 struct file **filep)
>> > > +{
>> > > +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> > > +				 token, filep);
>> > > +}
>> >
>> > Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
>> > Since, these new APIs are intended for kernel subsystems to participate
>> > programmatically, there could be IOMMU drivers (or others) that can be
>> > compiled as loadable modules. Thus we should export these APIs via
>> > EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module
>> > attempting to use them will compile successfully (due to the header), but
>> > will fail to load at runtime with an Unknown symbol error.
>> >
>> > IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
>> > inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
>> > during modprobe).
>>
>> Agreed. Will Update this.
>>
>> I think there are other LUO APIs that are not exported and can be used
>> by modules. Let me check those also.
>
>Hi,
>+1 to Pranjal's EXPORT_SYMBOL_GPL nit, and I'd like to extend it.
>With CONFIG_IOMMUFD=m && CONFIG_IOMMU_LIVEUPDATE=y
>the series fails at modpost, not at modprobe — kernel won't even build:
>
>  ERROR: modpost: "memfd_get_seals" [iommufd.ko] undefined!
>  ERROR: modpost: "iommu_preserve_device" [iommufd.ko] undefined!
>  ERROR: modpost: "iommu_unpreserve_device" [iommufd.ko] undefined!
>  ERROR: modpost: "liveupdate_register_file_handler" [iommufd.ko] undefined!
>  ERROR: modpost: "liveupdate_get_token_outgoing" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_liveupdate_register" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_liveupdate_unregister" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_hwpt_liveupdate_mark_preserve" [iommufd.ko] undefined!
>
>Two issues:
>1) drivers/iommu/iommufd/Makefile (patch 12) builds liveupdate.o into vmlinux
>   instead of iommufd.ko — needs to be a composite member, not a top-level obj:
>     -obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>     +iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o

Thanks for this, I will update and test this.
>
>   This fixes the iommufd_liveupdate_{register,unregister} and
>   iommufd_hwpt_liveupdate_mark_preserve errors above.
>
>
>2) Beyond the two LUO functions Pranjal mentioned, four more vmlinux symbols
>   need EXPORT_SYMBOL_GPL.

Yes, we will have a commit for those in the VFIO series as it also uses
those LUO symbols, and this series has a dependency on VFIO series.
Please see the following commit from David:

https://lore.kernel.org/kvm/20260323235817.1960573-2-dmatlack@google.com/
>
>Thanks,
>Ankit
>
>> >
>> > Thanks,
>> > Praan
>> >
>> > [1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560
>> >

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133779;
	b=fefxTmr9nOU/qJ1pZHlMxeXDRLOnQ2QyXdUku3Cn5BpXEieMs/SeUml718Vp2288ciJn
	 vp0mn8yZt5fCakrESnq0P2E5pObpm8Y0ea9PkGi2kKvpdY2rby1hTEXlLpcoYltJnxzHS
	 35gU5rD4BJO1f0vMOZvriE5wZLL0wAMZ8XAzjj38RQ3mYMz7bd4YTdDLC+//1zby9jIdA
	 stH/EP/KZkJ5yq+j1Yxcx2ZFDgRCvsyrADoBGckvEjucygiYiWnTPN6UAOtCEr3oM2UvM
	 XXHViAi7GXrRuZC6iXlZTHgY0NmRUrfvhHO55d1pH4JlbCzG4JZHXFdmx0ZZK34tETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
	b=ocQw3k/huBorxhU/alpbMTRcV1jx/PdWFByQYGwb9sI9ECftB1O0aY0cn+X9hX7TaE3r
	 lQ9zSaRdeBPZ/YwdecnSFjAYWjGSmCzCih7VN56M///faacuIP4U7SuoXA0zeMYjas3OT
	 FYvgW1ugcK2oBvSDPzsqgeVHTCwRYwSuVs89xv1PqNmo409ZGm6QxZsaiFClnbiXHy5rq
	 sBnsbz0wDH5slHrpRlF2urtxTbAhdgNUXG49Bwrf7Vug3zVorXcI9aQqGhfQ0Cdry4rxu
	 mTIi0SqS+Y3J8QSUU1xLT1JSpfV3s7E+gzbJ+EI4ONljwF857ojJRt8W0rlOkTUSYTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGxaXrD3;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB44606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 00:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB44606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGxaXrD3
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2efe0e3bdceso1297885ad.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133779; x=1795738579; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=YGxaXrD3nt6EPnZPTmgF4t/3KSyiOMN1+lC4rUXlqKhSSkNgz7z3Tw9defhg0JcLNz
         COBTxMkEo40/X8sRQdM7HVlPc4YBUI3BOWpsLwV/c+feWkZ+jerXEi5k9B1v4Aj35evN
         34MBgyEFqjzAAK+aE+r1l25v875SuA/dwjm66qDtp7iDEdwiA0p+BZ+mvYZYV55F1oPc
         ytJ6fNB2IkjgjHg7MtQPV87reMTxS9vehx9xnwzlWqfUjqDj2DcuXCbR7QemVG8EjrOl
         ViWGN5eNUOfh7oLjeYPYCv+//QPNGWVPjeqJ8hnRLVjPVuR1qlAszE5eQcyfvgAzj7Jn
         sP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133779; x=1795738579;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=OiHJZDQ9KH4tR+3ZjV88apEqvL+VzOR+/XSn77FSiwEl+KwYO6HJUGEv6bXzHiudqo
         rdzRxghdYR/esu2jARcIAn4S2YYLwWQhyVhel+k0IxXTKHu0kYLNKXdyxZBqnM55hErA
         nke92L/ZYsVMRHd03l5YYcjuAicvW3ZPStAXi/4AByfWU0y/LfQEqcaEiR3EWos4q0p0
         m8W3BgnzQ/4TsvYrxrk39PJC4FLDhS69tjH+MCdH/Y4scRlywZHs3X7kgOsaf9S5ztkT
         fq5k8o+x5C68V+A3b2FdQH/otldx/QnSiE9qUyzav8W2UU1nB6yTlfx/impcrFjYtgQJ
         lAWw==
X-Forwarded-Encrypted: i=1; AL+hErE6ojr95Nytmdn1NQ1J759ovwMBy3YRaEDWwEqnSIvHGUw1OS8qZIIMZpCmg4DnVEIhTes=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E19mj+dUUYju0WPj+1/gi/ZlZBUcyvp/EpZjzkpR/+qJaqvfC
	z9Vw/xcMal09uWLG1xfysdTyUmFPerDiClcLd2DwNIBGojZfSioZM6/qlZsx6nu+Dg==
X-Gm-Gg: AZFdTZfmXuVEzNHo5JJqj5jkNCagExTWvtzBPaDVdLTf0jgilv+GagXoIjfOUa5E60Y
	HtMHt8yryukbGVWJlPWQG211WCAgnm7CC73KjwYrxKq4hU3Radm7todC29K7CofR2myg0yJhpGo
	OjQptw4cxqkjSzB6GCRrzl8aVlzH7K6U6AlN4bW0lsThm8PvkVzuoMVbnQKr2ZVCygQW22guivE
	F3NSY4fDSW4gZqCTEe+UX2kmvZtRCXMl/OzqSuzvMBvHH55F0BASfXv3K3tPDNoCAQKxhO+MTen
	AGp+p9o+XIlRdwgUiiO6VdClWRlkIe8WFlRFM+8sD06+F6dgj4k4Smqlr8paabWWqcbzOf990DR
	Y4yA5JJtcDgryV/EWUD+EO485iFucqKE/fAP+uhOb2e9F/OsTXE+8obkSZyolGhqiW/RFxjH4aJ
	670bInQ5PagO6E57eSKqwpnhqylzIURw2fFvjw9uMgc1dsAMKqvhde+DNcUkTf41GzEHqVQwTHe
	KgyMGxRfVVANUYCmMFs5K7nNsUpcDmF0H82DLE1gPn/bbUzknKh+99dwzpdhFgMhYi7ocTaNws7
	muyXzyp4ZwSmmtJ4GDv2aJdLv/vfBEQJxSoJehZaeoZ6k9ahXI24SEny0ubYggZJ
X-Received: by 2002:a17:903:2b0f:b0:2e2:dfb8:818a with SMTP id d9443c01a7336-2f03f20f8c5mr14954585ad.62.1795133778058;
        Thu, 19 Nov 2026 16:16:18 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm6072095ad.13.2026.11.19.16.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:16:17 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:16:16 -0800
Message-Id: <DMZLTC9U6DBX.3FR19X5M2IT3W@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
 <20261118065653.GE2250529.vipinsh@google.com>
In-Reply-To: <20261118065653.GE2250529.vipinsh@google.com>

On Tue Nov 17, 2026 at 11:51 PM PST, Vipin Sharma wrote:
> On Fri, Nov 06, 2026 at 05:19:28PM +0000, David Matlack wrote:
>> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
>> >  * Open and return an anonymous VFIO cdev file via
>> >    vfio_device_liveupdate_cdev_open().
>>=20
>> Here's an idea for how the device file could be created on retrieve,
>> which I'd like to hear your thoughts on.
>>=20
>> The patches from Pasha at [1] lets userspace pass a
>> file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
>> next version of the tmpfs series, I'm planning to use that to have
>> userspace create the file and pass it in the argument, and the kernel
>> then restores the preserved file into it.
>>=20
>> I wonder if VFIO should work the same way, e.g.:
>>=20
>>   struct liveupdate_vfio_retrieve_arg {
>>           __u32 size;
>>           __s32 fd;
>>   };
>>=20
>> Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
>> the fd. retrieve() would check that it's an unbound vfio-pci cdev file
>> for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
>> attach the incoming state to that file, and LUO would track that file
>> as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
>> device as it does now. Since VFIO preservation is new, the argument
>> could simply be required.
>>
>> What do you think?
>
> Overall, I agree with the strategy. I think VFIO cdev retrieval should
> happen as the flow you mentioned above. I want to hightlight two things:
>
> 1. This will lead to lot of code changes happening in vfio core. This
>    means VFIO PCI live update code change will spill in vfio core.
>    Should I create a config VFIO_LIVEUPDATE for VFIO core code. It will
>    not be visible menuconfig option but selected when
>    VFIO_PCI_LIVEUPDATE is enabled.
> 2. List of other inflight series that this series will depend on is
>    increasing. It will be 3 (reset function, pci saved state, and
>    restore into fd).
>
> For '2', should I send v7 without changes you are recommending in this
> patch and future version of this series can transition to the approach
> you are suggesting after LUO changes are landed. VFIO liveupdate series
> will go through more iterations, so we will have opportunity to make the
> change. WDYT?

Sounds good. I am not 100% convinced yet we should switch to a
retrieve-into approach. But let's keep discussing it VFIO and IOMMUFD.

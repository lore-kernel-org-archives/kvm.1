Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4649BD67
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818991; cv=none; b=TSbmgkR/WoXKz90XQ6QCoa+Idb7Mtad+V/xJDgkrKMNAhxqB//IRPW5i98QTOszjwGYZcnpfeTEU9kviQEuJ/jN2jdQV/WlS5aWghZxg+BRs1+LA5/JBijgTzYBqXX395RLTmcGlrvTiRWXD3/zV7zosaDtk35mdWZQabRlCNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818991; c=relaxed/simple;
	bh=S/6wBu1Qy0PjFWFsGd4NPUc2/G0ASzabS+h4tG5IOy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNtrMYVOsygzY03kfMHykQTr3rVVdgfRYBx1nVC6UCZeerzI1+kU1X3EN0kisE6OVRtTNbvT2BvZk6nujbCf8txXcnjPxK+Vb8nufUpyPRkrEPyQjfp5u5TpgtSdlDtln2W7+OxI0qveXnqZOtOMqyIbicuYsZKpcgRKarMlFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m73PG3x6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m73PG3x6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a17baef589so16375545e9.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818988; x=1792423788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dHaZjZ/K9HkcWHP0xoN3hdI7zGw/VH12N/DXI78bY9w=;
        b=m73PG3x61KDHhuB9DVBfOJWPmuH8fpsxbuwo+uzeGLMXAJwi0r9Pruq63ReOCV5ghn
         DJcxD9KJlFH8z2oHQsI0eaPD3ARFY88vIHcynvXnkdKSu6GckV2Vdf2Ew5gY3HpiUKgJ
         YtvI4P228NiUf4X8SmWa4xcSQg5FZRLRPl03CO9mihO5i1UZDOCoZESurDyToeXEFZj2
         EXCYCQuCEdtiZMQt1k7YkXtjJR/XC9gWogq1Faj/NEtcPeUmelClnala+Lq/kAPHVuO8
         3EecEa8Gqz1LFhfWNFZtO5KHjyt2R5Nwm2FGpmu703LtgTfc5s68HRFSG4mlMdtuMivg
         bpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818988; x=1792423788;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHaZjZ/K9HkcWHP0xoN3hdI7zGw/VH12N/DXI78bY9w=;
        b=0hRpI2ItzfV2JNyX9UToq5Vk2E7XH7le9SQ6IfMB+sr8nx5cOomkrKjS4pnY9PGWU+
         jnhIxzeUVx9ypj+/w7q0aJc9MHLc38PAz1WACeBTb3/n1Hs6BiWX9BkKh5vBllkoTJfX
         AZAEFLRSy3GkIMmlyjFQmtJsnht3SGXJ/mSO18cJE8W1wt8nJ1CVcKbzqZOx+74QBc8h
         sp3qBApMfLubRomqUfVcwoZA92sy7AfAHyoW7ARvL9k5yvvGqujaWIn9/ZwXTREDEkiY
         67KUC5hPc0PljonMyVvtcoAKNgrNjuuODvh1ujIRmP2txQSMXKGDdVK9UpOsgLNuSHbO
         7l8g==
X-Forwarded-Encrypted: i=1; AKwUvBzLoXo/vMpQq0gROxn75IsUukrm1tDo3xEDxgCS4BfqimlnwO2YCsXjqzqBUn75tmHLZXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCTCKATdZRWY7H00622AaXJSJacwhIh4L4SqSZpgU2saPq/RE4
	x3RfTiPYlUnKNWMarJt4Y7bHQNg8IkTfek2QJJF6Oq0w8lHuJ2T3drES
X-Gm-Gg: AYBFou1iij0WJ+YzVKW6BLNAsmhR07umQduxm4z4/QA37CPAZX/sjSrkl5UV2+zIcjZ
	ieTAxUUmKoVNHVP0UCDFEKPGgs98zZWeoG67t5VX2WMozWSdmhOb3IE8TQDSH4n8MjfCLD0KtJN
	wFzcvORkLAL3hLz5ksQn4nFJI7ARFpRoh4k7zYR3HbOcYtyy6lpTduL+NZIrqLKEy18scctCXNk
	KfsBLO7nQyQsvE9YPIsUHDugO/wKswaNoq1M3JDTFnRC+28ZetLzTkUmqSwGKNMYwm4J2j/vxGd
	PxvRjDDJ4GAQE6G7h6f01VqU0F6E0UWyO8oPnvjafrL3xpXXtQEhGnlGIRJExC29i4XyIYaJ897
	oWfrPXl5OoZuohPVsmD6Q8f+/hHicg/L4L/sjDYqDUxosOF0cmQ1/qEc+i3a6Ge7JIpMjsOPg8J
	WkhHTf9FddJELp7jbSBtzAyKY/3DEEN2FKyJDrYa4+ztusrwV1TkRFWiB1kDLV4bDU7jArE6kpF
	JdY9pJDWHgxdawW27ES73OH9xgvBGRc/hWfkq6RLJcFRR7dNmh6DJ3mbpk4eBbxk0hUeWFDIt/f
	Xr/sJsJ95wp+0ITB2cvEti25bXZcQ8oJ5hw=
X-Received: by 2002:a05:600c:8105:b0:4a1:714d:eed with SMTP id 5b1f17b1804b1-4a18e4841c1mr177576875e9.14.1791818988354;
        Mon, 12 Oct 2026 08:29:48 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190344032sm299058135e9.15.2026.10.12.08.29.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:29:47 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Date: Mon, 12 Oct 2026 15:29:46 +0000
Message-ID: <20261012152946.63489-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012144616.GF14213@ziepe.ca>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com> <20261005132046.30025-1-griffoul@gmail.com> <f0077cec-10fe-400a-b229-f7434e297364@amd.com> <20261012144616.GF14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 11:46:16AM -0300, Jason Gunthorpe wrote:
> I don't want to keep expanding this hack in iommufd. If dmabuf is to
> be used then dmabuf needs to provide a pluggable way to fill the
> iommu_domain that many exporters can plug into. I don't want to
> hardwire every exporter into iommufd, that makes no sense.
>
> The existing arrangement is to motivate solving this problem
> generically, not something to be expanded on.

Agreed. The iommufd registry I mentioned above was never posted, and I
have dropped it.

The series I posted since takes another route, without dma-buf:

  https://lore.kernel.org/all/20261006183235.16576-1-griffoul@gmail.com/

It adds a small interface in mm for drivers that own memory. Such a
driver hands out files, and for each page of a file it tells the caller
which frame backs it. iommufd maps the file with IOMMU_IOAS_MAP_FILE and
builds the iommu_domain itself, and the driver revokes a range when it
changes. So iommufd never knows which driver it is talking to, and there
is no symbol_get(). guest_memfd uses the same files for the guest. The
iommufd part is patch 5:

  https://lore.kernel.org/all/20261006183235.16576-6-griffoul@gmail.com/

The iommufd part is mainly there to show the interface, and it needs
more work. Its revoke unmaps and then remaps, so a device can hit a
hole. I would rebuild it on the REPLACE operation David discussed with
you at LPC, with the scratch page as a quirk on the IOAS.

Is this the kind of generic interface you had in mind, or would you
rather have it hang off dma-buf?

Thanks,
Fred

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133977;
	b=tha+DADnwUB9VPpzDe77YbCdMYga1G1s8MBSbgbjD3UT8g/BCADSWyAmrPGf59aT0+Wl
	 BTmRWADGBvvls0jHDnsHu4Ut0BKVYcwknhkHsoakzFawGuX4fmragQchobISlkKfUrwMN
	 +GnW6qrh6aZp2KIp7ChNNFl7szbOjkjNFb5jZGOcz7/NuYVM9y6Zg6MuvmbDH5s67bU8w
	 qfSk0tytaRW5V+AsL+v1h24NIdEK26oiZW0zx5hzbBR451c92HQV+t1/svSAYJOUjOwme
	 +C+ViCfoaB0WnqPES7nr4uk8PaIZ9a5XIU8MhGl7BNiGAHrOSZBZ5dnz8dVF3VWKa8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
	b=JDZI5ESfsqFqd0SJSof2Jd+O7GMyLR7RgB1UPAV8YxRzlvgLo5oQRUQ1IuqeKoX2BteC
	 3OtCEw1yFveYQkaDgr9bY91rGklSYjJBDawOhYw9/iE80q0nug83TamEXJd9KUWUmAOOY
	 UB0/5DTxXvB3X+0QBJKjSPcfiWBiaMTklhPPjZp2d6W71W5Y98ZpDogXl5ex2t7e/7Fma
	 fllsXFrBJvh6fO2A4D7lKhe0lLmixqX6ifNTulkS4xGB/3du8m2z3eyx1lGR5b2GtN1VN
	 JKQ7k2Id3ef9vH4tZGyyWJR6DCkT+xaflyXLMgHqpYYFAgU7EKjpnBsAztrgxclqMXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PdhTt60H;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B03606A339
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 00:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B03606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PdhTt60H
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f00fc215f9so2197105ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133977; x=1795738777; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=PdhTt60HfDdlbgtnPHfsSmeHBydQzoPU7kBA2tY0Ozd78IUkx0lFNNH2yQEnk+t921
         4E9Tm4vx1WTnyn6wVtiNLws9au3Om8UjAH+aHWnF9UWUCSm6dRehNZtZrRMRyiJKAdfQ
         YnTwSvF8Sds1TTxbi5V/mZOO0ENi8tkjlt9pqsZCHwuUE36BF1CfNzDd6CjA1gvbCV0K
         t8tBNb4lXwSyQhCSx3AtuTpJROIDOnqKE7PXyQm+EW6Ikp8UHZwMZtLLhZ8OhuurDTSV
         31cPFPu1KFP9meTVUMuhIsGXcN1R94M301aF17ZwKIG89GFOnVfy1AAlTXsPDOoCWZDL
         cbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133977; x=1795738777;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=KcvkWHRaUdoXVWjR+Ce6bQkc4580QivmhzyxYa0sYwHliwNcey3BIXIhGkMQQ8MbWm
         vVv374ULMzElJRPZJgDf/Dm0GnEA+H9MR4pPiFp8dDBZz0wYZ8KZP6D9Etg9XAaTpx66
         DItu/EqRZHvhT9x2ri1acrnmTfcwgod5ibSXKYZ2YOzwSBzpDqMkDkfbDgjg3EGdW2XH
         G/m06j3p9SUtZ3RuqN41QKVZly54PL0VReMPRRcZuHvnre5mwhj8cwLC2HbIYQxNLVOV
         My1nriHb6y3aPMmKgFWWUBLakuFTpdLKImhwVXVA52RvPfwR9e7j7X7H+ypXt7FW5jE4
         qrRA==
X-Forwarded-Encrypted: i=1; AL+hErHxffWo2el4Slz6CF2cvXk+iIlYfQMM0wPH4e/ag51Tg76ZgzTYkw2ntT2mRZkRiNhSYKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JbEWV+m+9aOPNGeqm+SKT1+m01nv+9mZjdvMHOTYXibU0ywkm
	lUuyEzwVpLsx2eLgIiXJTIFrw4+hjYiovShK9m2N5GhmNic3UvysqVwkhbbU0aWYQA==
X-Gm-Gg: AZFdTZdfLevFiq+EJxbsx5QWAQwxOmhaUsdx4u7Ee4IuM3a4T4d62sPrQ5mPlDS1zmM
	IjT+jfxVn3I5Ho2Hr07lKSRobP7DNZ5XjqppQaOEJmtg4giVuxN8pzX/yutiujoqqjXgZMOM+rt
	F97kSRaPhkfhlx431s8YOH+8YIpaTD6mjYmjWti8PQXaZu/R1epFofgSNTduSILIw/r8qMUL5QB
	YPNWzvC9v2xv/9fpN5bsMS86Cf8jsq7ZdZOrwnOO285BgjHcQKKn/dJO0LzcQu9fMWjmSct4UFT
	9tmHZaFFSMldqfGo79Jm4zUdTPz0Whxf/tpUFnRCJNHde1ELRTQR3JHmYvOCTpomQJiylUAoyM2
	WGcLDjLzApGYoJ7C50cCW9L0XJGWwRQPu+Zs6+6yO//8VUOW7NgUl9YG0B8e+Vse5A82CA3C8X7
	+xdMWXIt/2Kry712pQVhwrauype2fYj9DEt0lOj49wpqIrCo2p312dLQSUOFjU2GxBBl+VIfS1T
	LX71sFWE0J5X6d0vt0K5fQaAF+SiEHljpZ4wFH0Y55qNq92cMBqt0hlyeh3mRkK4v0X6Hb+WboX
	+iiyj9gO3J1JiOBZyLRtnHEvhArs4Ngwfu7SrPXo8JD7EYsfBVigKFebcupJQxBa
X-Received: by 2002:a17:902:e542:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2f03f1a4967mr13941365ad.30.1795133975980;
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ddf40sm5969655ad.37.2026.11.19.16.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
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
Date: Thu, 19 Nov 2026 16:19:34 -0800
Message-Id: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-13-vipinsh@google.com>

On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 12557d45dfee..e6ca4c3fda06 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -11,6 +11,7 @@
>  #include <linux/cdev.h>
>  #include <linux/module.h>
>  #include <linux/vfio.h>
> +#include <linux/pci.h>
> =20
>  struct iommufd_ctx;
>  struct iommu_group;
> @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct v=
fio_device *vdev) { }
>  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { =
}
>  #endif /* CONFIG_VFIO_DEBUGFS */
> =20
> +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	struct device *d =3D device->dev;
> +
> +	if (dev_is_pci(d))
> +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> +
> +	return false;
> +}
> +#else
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */

No need for the ifdef here and 2 definitions here. If
CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
optimize vfio_liveupdate_incoming_is_preserved() to false.

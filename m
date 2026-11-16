Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853503;
	b=ZK/rNJomVWRVLqsUhDwxSS9nOy5aIUv7RjsESFXXMLVHp5tq8U8UnBTZGXlaVrKqxA0k
	 z+r+UIuFvJWSQjv92PXgLSG9k1LiUGGHki7cK6dD00RdyuGt9DOJP2Qnlpyain4PbbUWS
	 sL+bK7pf2fYA2FgDkY9ej9O09XeIvcTYoYdSdAOM1wAsjo8TthnZMY6TU18MLnC9u9GN5
	 3voDEe41Q8w02wwYJKg7moK6YbmiJ3BhjvrGBWXp43UvADQ3Kiq5s+PBHhbRaK0DLH/S7
	 S3QIbZ5lskMf1oeBOgVVNhFBLezVJzHuQSbuQhqYUQlGeRJi72z+L0x6zYwypdXv/Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
	b=1i9i5OqOCWkG3TmrCU4FQ7kkZz1ZuhE7Wygps6AlYMMKLGKHD2JQBljcqiYiN8MYynUa
	 mc9NgGBAUE9pVQhNzygnPC7xQzWbXTqxElhfhwm995mJC9SuaGrFEPohi5su+xP/qThGY
	 9B81w+TChOuXBDd+6x3Z4ezwbNsQD120S3Y3TJWF3i43q4FrPq2f8FUsyvhkqNGd2/RsD
	 qDtz90Vrb7Zh4P8/UMmTRlxFX/1SFz2sb6USO7+7mJTRyaA+Tq0xHy++DbZ3A6BrBnPvo
	 dRfq77FZeZRr+JX+/vIq1n7gtvHerg3BMDJBCzxB2CJ+OntzCXMc7rmtCahKlhDM8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JuOAH+dt;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A866606A333
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A866606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JuOAH+dt
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2efc4a84e75so3845ad.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794853503; x=1795458303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=JuOAH+dt4nSeYVPDWqUSSwy7YJdJu2JmWiFd7GUlJ9N0NbOQ5PpNIw5dvJitis52Df
         BYFrEtMVj4aLGHkc5ds5CXnaebVpnglMBaq2Mk5ojElmD6lvIPBOVaKImlpoGjY0gMDv
         BMx2gjvG3O0FBB13tvCPXuzojwHP80XL590WC/Br44NdxsMefB2SZOsj/8cLE16RPzUr
         Q98Hirg6neLXqJEd9Ip62nURakeSFCQ7j78Nx//cZ9ayAlgrXrxOyGqGrNqc7deumkEy
         u/MVp8zutMIiBglWP86wryLo6Fl8IPxQXN1UyNwdN1BhwVxLhJkhkqm5tVqnOQaIw+Wl
         M6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853503; x=1795458303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=GIE76i+TWdG6fE40dW+Wju4noEDRV0Iqew+I1Cl5Zup/HpVjQZfj1dodsB+xKINafi
         ItEui4ngV0IbI4m2ZZ+OZYnAvw4bKmeIlohgZosa+TNTM0YGgPRBQgA19AMpF/VNAuhc
         kTM9dQUouc1xa0J0ly78BrsG0C7yETj68Q3ODP0eSW8PCpHKrkCdWaZfoTs/uKqc7pz/
         2sCjLSawNlNPEks7/IP0qMGCsT4sJYodzIgBmU9bnF7VoJBgau5zIkKG26sJivnXcSHR
         pbAADb+/eemyxshiLkvd1cVoAdBI4nRrc0QK7mrfcYnoqzBVMGbwJiS97oWjrO6Iw/sQ
         8DxA==
X-Forwarded-Encrypted: i=1; AL+hErFQPHHUHOgmaTcp/nRMJCoVciSU29FUt/zNgDe7q1waI5NC4vr/9ukLbO+d4ZXb61RjSgQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TobyIVZn4Rq9Iiih0XsrxGW2Goio+UpAsyTZU2e3g2gMeA5D8
	uzOb6c7c3eJsdW7BWH41ak2U4V8yM/0zONtfxULceZRC0w530Hyb3Nc4AruF0KYJ/A==
X-Gm-Gg: AZFdTZcDUDp1utXOewVaJg2IIhOvAUI9TmTj7CRCbaumozCG/AOzlqTr8otYTdb2pC/
	cZ1e4MZIzoy7Aa8z0h1VXZAeVgs3NKNMOF52i0wGwhpZ8VUnppTCYz5Clm2meYVW2jeefUxXlxp
	Uh+fJBAgMP8MaZE731wuZDd3b6X7Z7SQ4EDdb4lgbr0eJh0Uo/+CoEwZKR0XbQbXAnov9FgNRt1
	QS/QoOHp2WMiRzpYkCwOkmnszLD1Wvw4hHPoqN1a6X094l/eieFo1xA+htEuMkpFErYPrzYWy+d
	aCu/Rlpoh/lXiDn+hxD3jLXXNlI1a/HNNwmNvDEP9u9ZfZJysliWRGY1Q9FPRPB3bbH7Roo2Ci5
	EbPnXJvU6mHG5yCVNZoU7FQX931rBFOrKauQfN/psgLmIubaiWadwBC/QOTv3AQF28g0GuWcx0x
	0EYneYzMXFr5OawkqNev0WZSfUcA1VPfwcOiTAmCCnbUDullCFVnQWFS1mv2Ye3XT4y7kRT28hG
	IivwDko7k3PmctKAwGloMiH5cmEsKyKgsivOz/qdbnIiUamXZIEsdspgDaXoDL5GFuCSlKWxeRe
	AhzmMYc4zPpZnef58RxNY00zYW3hTVjojqci8ZJ966ooaNk2cqyfCtHzsE/ob2XaSrCGtIZSQYT
	rTC90t2UNpzE7ZRCd4NfYqg==
X-Received: by 2002:a17:902:f68e:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2ee2b19e019mr7765275ad.17.1794853502041;
        Mon, 16 Nov 2026 10:25:02 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac70ea45sm296668a91.17.2026.11.16.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:25:01 -0800 (PST)
Date: Mon, 16 Nov 2026 18:24:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	Matt Evans <mattev@meta.com>, Matt Evans <matt@ozlabs.org>, 
	Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avtI--OIZu5E5sma@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>

On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>On Sun, Nov 15, 2026 at 3:19 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
>> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
>> > > Hey David,
>> > >
>> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
>> > >
>> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>> > >>     uAPI behavior?
>>
>> Yes. Even if we wanted to the locking is doesn't allow trying to do it
>> automatically.
>>
>> > The way I designed the P2P selftest support requires 2 things:
>> >
>> >  (A) initiator: A device that has a VFIO selftests driver.
>> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
>> >
>> > So far I haven't found a single device that can do both. But you are
>> > right that theoretically a single device could satisfy both
>> > requirements.
>>
>> mlx5 can do both
>
>Looks like GPUs and NVMe can do both as well.

AFAIU the memory BARs for GPUs would need initialization. The internal
VRAM needs to be exposed (mapped) to the BARs.

Do you think we should have a P2P device "setup" step that can be
implemented for various types of devices?

Thanks,
Sami

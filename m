Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647157;
	b=2fHQqKa9bLgOIQwIrtAAys7ZeUW5DO+bnb+l5V4kNGZ9xp3/FJRKrqBKp1p8WovjLKd3
	 S5V7Qw6CvY3pOZt1shpRZF8FdK10+ZVVDBrYNzScJ0+FnUUjIOMb4BdPtJim99RgT0eiX
	 4/57Gn3lSyqFiDw9YZAc67e7oYjQVzSvFUJYqrKFycopWi9Udc4eUl7qKgYEckFVF90g4
	 J0JuoQBgVbHywRnyAIPrZg9vBsj3+voqBXh7GR+dSqcVzzgg1D3KZZbCN6sep23yKsmgy
	 xNiJjR8xaGAEI/ryHn+EVwITL5rbJJ9b6CGvnJUwJ6LJszbU8YXyl8r0LPyXOS51ZIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OC/gY15cLyDwevMNUFIaNM4tFLtXDK4Xhw0hL/Ej86M=;
	b=Lf7vC+Bmytg3jmkYdenVb0Ur0OB0chDRqGq4rXEv0NHyPosK9CykDMZxZPkzmpzXtlE4
	 nWdS1bW6JpHIwZsXidpn6v8CoaL8vhYwKAUq7oIeazGDjqXftltQuR8WRoNhELJKPkrl9
	 IDnqWRfxvVKJnmSmqi7RJEgyst62lopXyuYyf9t4CiqOHMB8WHKcP2PRX9F5H7/4t1saw
	 Qzv5dwR9fzzSeWPHwZ8yW79Jlx/3qRObGvGOPqZm3OlZoa78g29clhbIkQgTAti1J5go8
	 t+XJbrjS9nXIVYXaIWThlqecHco0rwJfq0fan1EuzxZuMQg9jj+uLpoCHhtNSGXGmwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NB74w9rB;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A0606A32C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 19:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2A0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NB74w9rB
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so22129695e9.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793647155; x=1794251955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OC/gY15cLyDwevMNUFIaNM4tFLtXDK4Xhw0hL/Ej86M=;
        b=NB74w9rBrA1Fnaludy1HBowebMeI8FhFmSUNE2JVYGwPjKwXx9TI5xm7WO8KeiOryK
         d702aUwvSY25jzV7QZR4CZoAIzB40eqzwRv478T/lL2sBsDIggpSeSv/QJaU/p0b2Yy+
         tFtTg/CrEe4Qq2P//4lkseZFThzb0EIKz3XbFlWf+AmjBz/htDERW9z6CuHXf9CKGXNh
         e1ltXfcu+/VpD9gV5+5ChwmiHXV0V+iZBHEp/Zpra6wqD8n80ubPh8SWwCTeTBujV8ra
         SZ/lvge5hburvPtLszH8TycgZ9FtOIcKo92fmxORITiMn6Hyrla0+tia6Wa57rORP+Ny
         JvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647155; x=1794251955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OC/gY15cLyDwevMNUFIaNM4tFLtXDK4Xhw0hL/Ej86M=;
        b=2Nnw/5agMCSeE/klF3+vqjJemBi+lYVmk95pOuYcVNgi7ghvSKFI0jbDy477l9H90L
         DWNTuj4PWqSPpShiGtDNpnvc9HU15qxn9Mk+W6LichY0hbIRTz8oxEIzAFwf4EdIRGA1
         6Hx1fpBR+8L+NZUYhE+lWl4Dn6g41kk+3kZ5k0v8OsNyXmYvukUe7JfdwhWqkfeB1E6N
         VnPJ2pJqWuc3pH21cdCHJWQOd9fZ1PssX5kjPGUQe3pbJEK+Y1MYJgs5Dz9IiGi9c85L
         Gvlm8ocCvSJypli/sdjxCfuJ3LfMM/Pw6hKSBN8CZElzzxVE40C3o+i9zqVGli5lr0fL
         KCHw==
X-Forwarded-Encrypted: i=1; AKwUvByLvmWY1WKezUiqaFZ0cRKc4Yxr27Dz8or2kKF0QFX2pFI/Ymgm32gwOuBdYZ9cqFYr6X4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdZHf09jGXKJXeRTSUiRuk73tFt4EFw/X7eZyPBQh9VZ8zpcjx
	zN+bJRaZNOXgKUJUJcI4F4l+jHwIiRyXucBSl5TbqrDGklBetpytAqg1iBRjcMFpp8I=
X-Gm-Gg: AYBFou1WmW+tfO78a3G0D9thtYAeYEd3oEh6drToUNHRXl9gpBkAV90ysylfzh4k9sl
	AZgPALReJ5RKiWJR8HEVjzW1bbfFAOpQ5I/Mm0LaIesDrKvk+03mOlv2dKAVm5sYP7OViBf36lI
	E4Gw8ChMp9+1I6Nb7EO25XxvjnZgIsVUSCvGGB2iQ+cFo9m1l3FSkgwrWHX9DwyZws/au1j9Ckd
	+VWygs56BELg5Qnb98qYmjOW2mKdOigZJTjWwc4JUHZ+9ACk62DRNoASudn+mYD4QaY9ebLaTd4
	KgnLDraU3dgI9CUzjIoI8hQe5OMF83X33vFWY++zPCtuBotzc0KFDRaXUSDNy2D6+Ox0BoTLuOA
	nmTsK/fmjldvpJZ2n1uThlGvNg+1z8KLrodXj6G6GSTHFmJmZA/J7qj/+OtNhOAVFxnOVO878P0
	Xr8DkuBi0kFb9VTgEIlJL+32eyldOw0u3SGV1vC4sQMV16mvG2xxdoH1YizfWsEo24Bfs37QQ2w
	M9/OjJGpsC65RApy1O+GbtbJNRdmZno9JwGwCHaTJfqBo0FP7p6mxc0mwW8u++28Rh2xrAt9qcB
	I7JUltNhvAAAI69oQTfoJr46efiWmzMCCu8LraCB3ts/ViWjarSvudo+R417
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ac150b38d0mr251477715e9.2.1793647154958;
        Mon, 02 Nov 2026 11:19:14 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aae24b32sm6083675e9.12.2026.11.02.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:19:14 -0800 (PST)
Date: Mon, 2 Nov 2026 20:19:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 08/20] ctlv: Prepare message output handling
Message-ID: <aujiKOR-JR9kTMia@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-9-jiri@resnulli.us>
 <179302367451.58760.3909701518454079333.b4-review@b4>
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
In-Reply-To: <179302367451.58760.3909701518454079333.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> [ ... 498 lines skipped ... ]
>> +/**
>> + * ctlv_op_query_done - Complete the last query fragment.
>> + * @ctx: query operation context
>> + * @generation: current data generation
>> + *
>> + * Return: 0, or a negative error.
>> + */
>> +int ctlv_op_query_done(struct ctlv_op_ctx *ctx, u64 generation);
>
>Typical kernel style has kdocs in the C files along side the function
>body not the header file

Okay.

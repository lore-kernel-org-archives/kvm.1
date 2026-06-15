Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F527FD43
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566438; cv=none; b=TZX9geqlWf3c8qDl94hq67H10S7eEHjjv3SWqACCOpv865+WMjl1BbPkMmb8ztsyuw8aH7k/QARPj5FlJ6P0KWEwSERc0nWR2/LVuJy1ZHoyAHwT5X3PgDFbYMaY+qXrVZWbEn1+6wmR7F7BT1mLzwleW7aY523UioMQDC/Vhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566438; c=relaxed/simple;
	bh=wkWq1YyQe9HfMn5h5fwETvev7LwtmAAMc8+W6YYydmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyJNh5KvKmZbmjunjpJ5JjUb1IZogppHVnZUjXKt+Hc5gDPQQ9IfhRBfDyJxJFCiaXGuv/t6+n+B/QlJfNmpLb1omiWF2Ru2l+0S4WBnvBldw/wL6eEJfdljf1c1KFVrokjEbKO3FOxq1qz7VK9fsT31pqDgbjq3olIExl9L1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAp0NZoD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAp0NZoD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b1a48855so25065ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781566436; x=1782171236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RZpXrhOisaz0Hy21Y75kOiIkZX6dkWHiipcMDxVBGY=;
        b=XAp0NZoD5l1PgFxMpubiNVcwO9ElOcTTqhX+narwtcVZO+DUd82mBQYyQwKMxjuwO9
         TKdw/T/3+ASzaVaG/NJi+Ghs3b9vnJYLBFoUf3VNfaZR2fT/pJ95QOOr/u/hwkFkjbgG
         H65+9hof3ziKy2GkymwmN64YsZsYQo60737v6UWaARPxI2eJHs7uvSbRFmBB34Zf1DHU
         BCofUzJ/NlGcIJppxAAYgXdRjSX3ZYu94tqD5lVMSjcqLe/shcdOD81Q06nc0wNvVcX9
         u+bO7+qaFPP31xLcum84kTqfey5p3bleLBBA2HQwrmdQsd28fBNxNU18LbjDmkSG27km
         WFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781566436; x=1782171236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RZpXrhOisaz0Hy21Y75kOiIkZX6dkWHiipcMDxVBGY=;
        b=nw9vqplkZNNNMX4IDWRZ/UPiIYKmRN1qtXmXp4ByApmcF7/msWEsC5fpIM1TwcQxtQ
         WNfJ3vTF3rHl14RIUqPgAE3nD63RzJLBlzTtcvvFgwn0XMfKmhQKcXN+uhIW56DDRgHz
         CxoElMUrsD0db66efMNpXOYtAX10xvgQtTef8aiyPw+zt1ocwhrG24beVlPSDlva8NZX
         ng2W7gLf3oGNS/CpxFW9s56bek1Utl8DkcFw+7cNwjqhBUW7eydR+ykDl09hV8QJCPBN
         Jfk2vsfY/GHFTW/USKD0uKmznjdh6yYOdeymfe6x2uSA0JxCOdK0zmYHDCT+JFqopYrn
         ZIBw==
X-Forwarded-Encrypted: i=1; AFNElJ9WKe/MubZouKkoz48xb/4RbBotwwpSa0TzWNaubzsXK29cA4c6i44R6rDOez4vmzzRV9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVWjYz2+19ezKLlP5bnfh+Qzin8F68BLQVpV/cWVmKG3Z5S+Z
	b2joPnmKQwhBfyoUXEpShdy5pTDEXyNCAKWSJU09pVBEpqN42M/3KdBtPN19SGUYtA==
X-Gm-Gg: Acq92OFpRnvbsUQzci5bfMCYhtifg1eILA2v4f7nsjmezCHAPHKCmlPDoNaxM8ukn12
	eYYWl78HLpZaeZUySslp/QUN7/GuypXASiDKxzWSPlsHn/1C4PDtIvUUPvk42DTXdftHUP2NtFi
	+H0qfUG6css2OOLHcb6GJuwN2eq7bYF+LnPNPDl/U//KJc8syVVMpJTTRIfFEj1NXSJKYOWiDVP
	Ghv1FJk1UIryyIVGUduXmdAM0SqqCzHkyKpTGoi2h5m8ulynhAq3v5fcQdF73YLf+UFZ5zjrl+b
	rxxQ0TEis18QHP4VX8buxZKi6yrRE+V/1UoykqFyPfb347QRuxXI4HvR4F6EcwJpj6d4RLnxqIN
	VNaEPN8QWGtYInfh9Ui5pNLl3N8z0uDjeGWE0VGpxLcjTeUIoMJ8GHECqumN8EZJFiRu6ueq0r6
	qEhzreoeb20g+cNhbBb/ezWfR1Kv6sBiOI/keW3V2cZfT3MQFNUGhSZebR
X-Received: by 2002:a17:902:f541:b0:2c1:4228:3321 with SMTP id d9443c01a7336-2c69a2c4cd4mr979115ad.12.1781566435833;
        Mon, 15 Jun 2026 16:33:55 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac631sm112076765ad.44.2026.06.15.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:33:55 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:33:51 +0000
From: Lisa Wang <wyihan@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Chao Gao <chao.gao@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v13 03/22] KVM: selftests: Initialize the TDX VM
Message-ID: <ajCL34gnp2nDVM0K@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
 <a58e2941-77f9-43cf-a54d-023506dd7eb0@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58e2941-77f9-43cf-a54d-023506dd7eb0@linux.intel.com>

On Mon, Jun 08, 2026 at 01:57:24PM +0800, Binbin Wu wrote:
[...snip...]
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (u32)(_flags),				\
> > +		.data = (u64)(arg),				\
> 
> Nit:
> The two lines' backslashes are misaligned.
> 
> > +
> > +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> > +({									\
> > +	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
> 
> tdx_cmd.c.hw_error is u64 and it could be assigned to ret, which is a int,
> the upper bits could be truncated if the upper 32-bit is set.

Thanks. Will fix these in the next version.

Lisa

> > +									\
> > +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
> > +})
> > +
> > +void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
> > +
> >  #endif /* SELFTESTS_TDX_TDX_UTIL_H */[...]

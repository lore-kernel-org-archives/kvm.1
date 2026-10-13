Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926414825AF
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912829; cv=none; b=l1SpspNmy2BRkE1MtBEYoLi+piOrqN8QbqPkma/lofl+C3BEtv55Ul6B9K2WLNEQOR4Aji/X9tWlPsSwqEwoCkhN5fAAQDhlBp0eMFtOD/5OVCMZpdxnlo4UlJBeNGeDEDbN/56e9qX1AfXdG9ZNYJCvDWYul5YT/iMkrymDFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912829; c=relaxed/simple;
	bh=m+i5mTlUxTCnrCi8WzAtmzzFXQV0rJfs+5MtNGiKS8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7msHMnpsrjgMNrpztv0PdjPZivxVoHKt9KIpjChrmLaR/c93rVTqtlail472Ln4AZkCf3cdbT6zSS9NUx/oNdm+oeq2Xy/EzbEwhZ3JBCF9E8Dce51LfRpNfYje7TG2/CX+8r3HVpYAQTL1N1/LcDTfawwhJBNyGKSuSOO9q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5Vy0NpU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5Vy0NpU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so164695ad.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791912828; x=1792517628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qsfJHJAdVQ83GKISdOFSgeXuIu/91TZW8ltTQ/2oo/k=;
        b=L5Vy0NpUII7ewM/cx4UM0kPWRO2ApbVBxPubGhJKJoRK8E4G23eV28CZ5n2zGZgqCT
         kWH6aZcup0sUVpj7m+mtINUa9yqzqOfc0Vtdrd5Bsxq0iDa1tJ5a0YvV1bJO+QGxcWF6
         DWSlHUYrim965MKghcbksimcpWRqKQQG0o6DYAw6BUkoidplq7AQbUdXs4AhDtLzTVeh
         9zQFu7w+bEvc6/vthrZHX0tCPIK/2anhyYgtUN2ySiCFOHQjHNw4xJBYMuI9aBL6UvkX
         srwM0xJqVYQq7P7jFtgFh5BM8Kt1PMSJdybasoucH8Rayt8/qW2BviKwHa0ZWQP0sJoO
         cyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912828; x=1792517628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsfJHJAdVQ83GKISdOFSgeXuIu/91TZW8ltTQ/2oo/k=;
        b=lkl+U/7hUdlx1fnVgkBPQondUMUOsU2A+/qzDgB7rdDJUFOhR5lClQCUy1vToo6oTi
         98HRfghC9M4iMez3N1prnv/MxNO8r1l/w9h+IH1C69RQQ4nQbdjv0LbaAuF73H3gqd4K
         fY/DJgPU2mgNp266L4ak2295o/HE7mB4SZARE5pesZHxwSKNaIzVfDovFoPA6j4pBycj
         GC4vVargoYybdSsVFgU0Cbr/8ffo8w5ndWFF8udyrEA3yy7Ko/+fQFprpCNpYhZI1b1m
         mVvxUcDPwxzRnjgl50laFtAdTVXONLGZh4b7uKr81GTkV3tvyj4fCherQ1P1BZxmT9ZU
         3WwA==
X-Forwarded-Encrypted: i=1; AKwUvBwvPsgBFYoy2WxFJgoaTy1+hZdFaUcJU1mcd9G8kcOIQnx0Wk/vhiK9ECDV1sMi+1D/2FI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8xfMwAuNso5v8fexROvri8y4TuOLDfwukhzxuVbrKYER85Hz5
	CWNnfQMZmqSwaRDUcR/Ucw74HBEFcpZWpsCUVbxd2peqvtuWpT6Xmog9l2vSois8kQ==
X-Gm-Gg: AYBFou1zolWYhMp92yPxa6DRHAQaS1PYAHzWRYDTpw9lhyF+LArZ1FXNgjKqFg3fy/Y
	8HHFBYOEEnkwqdefIMNF9bqemOQLNROYCFtSdEBp9HBqHPXU7iXnj2lQFFZqYWu08Sk4fQRnXjk
	CRHCkSi/9VZkd+AuTTB+oSdpMA9L4IUjKWuwvfeSCjQdqASf0X4YMmE01aTcvpfkCCTUpbQkyqR
	19cy1zUhbFccrybVGzanRlaq98k75O9ixzdEFC/cv+/VZ8VCue5AxfNsOrt6wJcYdoVfvxnf8Q0
	sujhP3dvG7RnnPzp6ZUl9B1SawxuP7Iz8LDsRlGMVQP9rT251+7EeAYVsgsXJnelwrjsFJ3MBL6
	Fosw+OLM/lVrpuT0Oy+AGVLbzKJhlIksbQeqQcDC8K5SdlzwNk3zcOVOLns8bE/84LydICiBPYf
	FzcOc5UMnQFEPfGnoi9sl4Ul/fVa+Pbf4G2Q7iY4wNwoQHL6Ezbq+2XxB/18I+wofFfffgLB0VJ
	Jex+E62/mseZa/o2UcIJ4juWdEP86fv
X-Received: by 2002:a17:902:ebc6:b0:2e2:d665:6ad8 with SMTP id d9443c01a7336-2e87bc2190fmr12955725ad.4.1791912827258;
        Tue, 13 Oct 2026 10:33:47 -0700 (PDT)
Received: from google.com (75.57.168.34.bc.googleusercontent.com. [34.168.57.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac600a0619sm637262a91.7.2026.10.13.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:33:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:33:43 +0000
From: Lisa Wang <wyihan@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Chao Gao <chao.gao@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Subject: Re: [PATCH v15 14/23] KVM: selftests: Expose function to allocate
 vCPU stack
Message-ID: <as5rd8F3pLmimtGe@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
 <b2143700-da36-418c-af63-0b50b33f080e@intel.com>
 <932ec219-5951-489b-bda9-1f6e9a605a9b@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932ec219-5951-489b-bda9-1f6e9a605a9b@linux.intel.com>

On Sat, Oct 10, 2026 at 11:54:42AM +0800, Binbin Wu wrote:
> >>  
> >> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
> >> +gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
> > 
> > Besides what Sashiko pointed out[1], this patch was just messed up during the
> > rebase and it even doesn't compile.
> 
> 
> Yes.
> 
> And since the upstream code already has vm_alloc_stack(), which basically does
> the same thing.
> 
> I think this patch can be dropped. 
> 
> > 
> > [1] https://lore.kernel.org/all/20261002091331.BA23F1F00893@smtp.kernel.org/

Yes.

vm_alloc_stack() can replace kvm_allocate_vcpu_stack(). I will drop this
patch in the next version.

Thanks!

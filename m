Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB33ACEEA
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824056; cv=none; b=huHMFRAQwiis8m7qKpajoAaEP2TU/4BbuFQ/OP0jdQJJlL2soUQMBUAVhX6sAMMm7Hd4Yd7dsfp4My4gTzfkW9kt75Xxir3mDqWaHTN9wMPhDTIQNX4LITDAWbsZlUMZYLVeVn6wfyI9k4+9SsJDD8yY/tVn0p7UMCBpKKdFQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824056; c=relaxed/simple;
	bh=A56OfPZZVFGIDpDQ9XCz9cgezTjnSLv3WNc7P02MjjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx5OApOFU30+QqGWnbsGNL+udE7FWxXSDLvkJz+BNacihJx1fzjasjSBeBVcZXCKtSpUTSPJe3HhxK+x0vke89A472fCVf72jLWOyhQxizbWx30KuO/sR2MGVNh4/A/FtAskf+cn3qE/IR50L/EP1E7F8+woLg+aLKcIPlVRH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUlJiwTo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUlJiwTo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so83055ad.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791824054; x=1792428854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a0L3N3ZtqaociPWUQTHB7mjZkgiRjSPFirVt2JXOStg=;
        b=jUlJiwToZneaFf/XGv1R2b7NkTk1TgB+tXTehhHw307Qv2oKSmrHNZet9etW+rUfny
         I2CMVT85kM5moXip9hbDWl3gXnWNZatvQqcbpcvXksr1k8QhPIXdzO0K7+YsHS6+Y0H3
         DnkcoK5jzq6ZOVXv6tHPEzo4ictXebQXXxNtRXcoBYkMt4ontokiL6JSZw5Fp2rZ9dws
         tDcLd05pSJFRxH0/kKxcQZXOeVJ1kGtRlSd9tuREy0KmoslOoccfWJ4GTYHesX6N3H5P
         jrQIThL6I4gWvyjwwq1oYyLS2oHF2MfUxabg4rPS5x6tTxJqb/rfLH9mzayGn4ZH/3g1
         jdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824054; x=1792428854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0L3N3ZtqaociPWUQTHB7mjZkgiRjSPFirVt2JXOStg=;
        b=NsLukB6knMxJMn9TtIc9Cqw4vfeek22NFCZw4lUfbeK0HM44QSobLJfk1lSwm+Gt6M
         PPG2Kdp3zL21lBbBxBbCEhDfU+S2fRIua0f5pTGpXlQCTDlV2KgbKDgRP4gZYhLJn+yi
         lW6kmXfCLSQbIHgdCwnDaDQJVriKYRe9vsHbX7EFDIyBCl+hWZmYxECcpw3keHRaDCVR
         KgIRZKnCfql2nt/UcHgcTzDvV8H31aQ5bSh7NJ734VvLesGy54PXROsmrYErmGQFwfVL
         5P/1ncvpAytfaIdaZ6m9DZ2SY5HqdGlYJCfXZV4oGY1NZvA+HH1leRZ/mIYr/f+Xt+O+
         vhUg==
X-Forwarded-Encrypted: i=1; AKwUvBzBKTZ0BPprfNrq1ztSuNw9RBEWgLw3KQU3fCII6iSIJsPKfS9SB82EROxw4sX5VmCjhoQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0D410nun3kFLznOd8A6MOkLZx0gT7rCfAXKq/0359/QyqzyDj
	5g4Pq03AwTb8hD/i635ryQ1/gFCiAQjvyMroza0kVd8cAQH0WJJgxW58vd8rGp507Q==
X-Gm-Gg: AYBFou0RdlXbWubmvFMSFFCKEQ2PwS+5AjQhs8EJSQLmPf79JvIFTbywXNCU4RuvoF5
	VtMu5BeuZbwEfP2koXqcxKdwHTUkSpw2xknNsil+lGauW3NIydoQAEneI42VW1kKvpdK61YC26k
	MejlgsjcWu6wxjXppUPGP9EVyhNY4a/eddccNtnTbtsHNUZLOcqz563kkXKCrgS6HbN0R68piom
	zBgW4qtM9pTM1LaE6w/AFn1gch12nuKMuiaqzHJ0KEvgoAIXeMzAyEOD83AeKMIyv2JvCOQNSG5
	IwvGFh2zNVaUYG/9w+SouDIZj7VFdfC1ZFl3Q2Y5wLOnmJ7dv1J1nSEcPCyuDA+Wu9eQgXx6sIf
	D5ZCpUjd4KVqzT+RWgJa9HDermQ8gnfYmHTr4QtN7Kz2RiQQosafGJlI3WTPpcyWfvesXCP2Gh6
	Fd8lVPZfHA0ddzKNhLLwHhCnQ/fA9KDzbhtYFSupoYTuoVtgemQAF0XI9N86SIY4gZa2XQrLlCB
	BKqyBVV99YfgmaRc4LZSJQcB8x4Hs2E
X-Received: by 2002:a17:903:390b:b0:2e6:1917:fa with SMTP id d9443c01a7336-2e87e2f872bmr6833435ad.7.1791824053720;
        Mon, 12 Oct 2026 09:54:13 -0700 (PDT)
Received: from google.com (75.57.168.34.bc.googleusercontent.com. [34.168.57.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab393efd88sm10301280a91.3.2026.10.12.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:54:13 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:54:09 +0000
From: Lisa Wang <wyihan@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
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
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v15 11/23] KVM: selftests: Set shared attributes for
 ucall guest_memfd pages
Message-ID: <as0QsZtRAEEq5Tpw@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-11-7c62a5d8a992@google.com>
 <7ca516ea-a931-4497-b3c8-b62110ae006a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca516ea-a931-4497-b3c8-b62110ae006a@intel.com>

On Fri, Oct 09, 2026 at 11:44:55PM +0800, Xiaoyao Li wrote:
> On 10/2/2026 3:37 AM, Lisa Wang wrote:
> > The default attributes for guest_memfd pages without in-place conversion
> > is private. 
> 
> This is wrong. The default memory attribute is of a @gfn is shared without
> in-place conversion, i.e., with per-vm memory attribute.
> 
> We don't need this patch actually. And I have tested with reverting this patch,
> with both out of place conversion and in-place conversion. Both worked.
>

oh yes, I misunderstood the default memory attribute without in-place
conversion. I will drop this patch in the next series. Thanks!

Lisa

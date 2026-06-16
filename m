Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9729411664;
	Tue, 16 Jun 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600237; cv=none; b=ptSgiHhW4ZmUl6KmpQNn57nnB1Lj0EEaEOT4q7kml3UwMZpVZSroZkDzCN1at21acYqF+shrK40a4UH52fF34J97cRjnwkaj03NkgOfxuY783QTXrLlSfSij/QcFnnPUPFNHb0FwHHgx+UsuMGgeLJ5R2dnnzaEloJKlKy9bQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600237; c=relaxed/simple;
	bh=1e3LlVBULL94K4OR2/cvcZTCxBPThyoWu9as3n1vewo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDI2BDzUT0xlRqtl1lQz0ic96xlaWZuScAp+nz13X1riCUMicD7npXoOJrZQ23sG0KUJRVGlCoHiTSpdbGMLpi3n+qp3oI8ZnKSSHs4hqanatUl/k0fj9apTwizat9hwUgYcl1HNOQMqcekBnXS3qsx9l9js5LE0lKWett5hEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1nvaNBG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1nvaNBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781600236; x=1813136236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1e3LlVBULL94K4OR2/cvcZTCxBPThyoWu9as3n1vewo=;
  b=W1nvaNBGthFdeZwRcv1VzYygM1zOJd5hEtQ35ekUIoOEGeQiA7QlT8t4
   +6Lqdl6wRZY7NUPKVJWN1KqedzS6B3qz7M2QvEAVY2tgIt2jorrGRuzQY
   AE/+SxPb8AGa3FO2eJ67IceGqqgy0NBN62CAaaMV2rcBv+rs3il+RYXNB
   71YhENmBTmJuaMHvT8eoUf1YSfJTT15GZuoQ7g/xRsuXiU1HSHFf6BLyg
   URqdw0lJ3iqz9rlTVsBpDLXuS/XduErPUGTDvOTVQSUgomzm5eH0yA5NE
   tMFCZMHCXEPW9if+uz1OrKdXQdHVRQN3zPLsYieTAXMWL9BbC3gd8g+e7
   g==;
X-CSE-ConnectionGUID: LVF6q0wXR1CZNUMaLINHNw==
X-CSE-MsgGUID: HwASjuMpT5CbIlJi5Qxzdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82371496"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82371496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:57:16 -0700
X-CSE-ConnectionGUID: gXEoff+HTrS779D3//JQAw==
X-CSE-MsgGUID: GKR0w9PmQt+FMMvj+u2huA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252021497"
Received: from unknown (HELO [10.239.158.65]) ([10.239.158.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:57:09 -0700
Message-ID: <e0b99e9a-c20f-4def-ac4b-0070996c10ef@intel.com>
Date: Tue, 16 Jun 2026 16:57:07 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/22] KVM: selftests: Add macros to simplify creating
 VM shapes for non-default types
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-1-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-1-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Sean Christopherson<seanjc@google.com>
> 
> Add VM_TYPE() and __VM_TYPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
> 
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> Signed-off-by: Sagi Shahar<sagis@google.com>
> Reviewed-by: Binbin Wu<binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> Signed-off-by: Lisa Wang<wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/include/kvm_util.h     | 13 +++++++
>   .../testing/selftests/kvm/include/x86/processor.h  |  4 +++
>   tools/testing/selftests/kvm/include/x86/sev.h      |  2 --
>   tools/testing/selftests/kvm/lib/x86/sev.c          | 16 ---------
>   tools/testing/selftests/kvm/x86/sev_smoke_test.c   | 40 +++++++++++-----------
>   5 files changed, 37 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index dc70c6da63fa..041bdbfb93f7 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -233,6 +233,19 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(u64));
>   	shape;					\
>   })
>   
> +#define __VM_TYPE(__mode, __type)		\

It seems the name "__VM_SHAPE" fits better?

> +({						\
> +	struct vm_shape shape = {		\
> +		.mode = (__mode),		\
> +		.type = (__type)		\
> +	};					\
> +						\
> +	shape;					\
> +})
> +
> +#define VM_TYPE(__type)				\
> +	__VM_TYPE(VM_MODE_DEFAULT, __type)

and I think making it one line would be OK?

So something on top:

---8<---
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h 
b/tools/testing/selftests/kvm/include/kvm_util.h
index 041bdbfb93f7..a1b5d2029d05 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -223,17 +223,7 @@ kvm_static_assert(sizeof(struct vm_shape) == 
sizeof(u64));

  #define VM_TYPE_DEFAULT                        0

-#define VM_SHAPE(__mode)                       \
-({                                             \
-       struct vm_shape shape = {               \
-               .mode = (__mode),               \
-               .type = VM_TYPE_DEFAULT         \
-       };                                      \
-                                               \
-       shape;                                  \
-})
-
-#define __VM_TYPE(__mode, __type)              \
+#define __VM_SHAPE(__mode, __type)             \
  ({                                             \
         struct vm_shape shape = {               \
                 .mode = (__mode),               \
@@ -243,8 +233,8 @@ kvm_static_assert(sizeof(struct vm_shape) == 
sizeof(u64));
         shape;                                  \
  })

-#define VM_TYPE(__type)                                \
-       __VM_TYPE(VM_MODE_DEFAULT, __type)
+#define VM_SHAPE(__mode)       __VM_SHAPE(__mode, VM_TYPE_DEFAULT)
+#define VM_TYPE(__type)                __VM_SHAPE(VM_MODE_DEFAULT, __type)

  extern enum vm_guest_mode vm_mode_default;



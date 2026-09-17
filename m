Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C73AD535;
	Thu, 17 Sep 2026 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626477; cv=none; b=AyYYb8KJhnEbUkERyRGETuu8QVKYp4/I8AGcmS2Xb8L+1erTO3eeGhR+gCMLK/aM80Xc94l5CNAELgeXdt3KWTzkulZHyA9IVL63O9QKJuTg7Hq9cJqTE15j6CF9tijLxLIZ0MLQdmpnGg+8mAgQ7v8c+aWms6c5BDlFK+wSqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626477; c=relaxed/simple;
	bh=6HgOEnc9wNdaEzeo1Tl1Hz7oAQt7xSh7oQ4zoNXsuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjUKQOG7WoadXy4eBvdYrGOgiT0nVgz+xlaK8ZNHzuiW0pkKRHRpcbyvC8/VzxCzda5X72iTNyGZoHRyyfEqXW7zaLX5c6hWmg1SPE1YZdnbqzfgesut+hciWE0pEHqT44qkF9vW3MKt4TVyRrWdzWdMjaN5yj4YX3TTY+B/PO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzGKa3ql; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzGKa3ql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789626476; x=1821162476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6HgOEnc9wNdaEzeo1Tl1Hz7oAQt7xSh7oQ4zoNXsuWg=;
  b=LzGKa3qlAlYXfYmJ08aP4Q0MOLq8Q0008vm7oym4JSfopvOfZaSE2Kiz
   ilr4VtdthFLyI9uSiTBrOjUX1rXxyrvIxgNSMCOj7WomLSnp9VPgBMPH4
   ZZEO8OPLKFuZBxuACO/T+6nju5TiCCiCnAeOt+m3PC3mQdwrpMbgdVy6F
   /kCKr9wtA4He065UuAXiVYiQfkoSxbbfgSOUwriyB7jdX592ksJgvGDzI
   9Timv+2qFsZZGggU6RovRFSeFzFci5gfBIS+ST9ajPrt2UXk608adbWwL
   F05OcLOakq8VMTnSg9nM0LbAjbmBa+pq8qtNGjGohd6/WKGKjJpa5qdh5
   g==;
X-CSE-ConnectionGUID: qrzzvqNNT3O8AA+YGw2WDA==
X-CSE-MsgGUID: ujyYDf2YT8yUlIklak9LGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="523766"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="523766"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:27:55 -0700
X-CSE-ConnectionGUID: le6Qgjs9RQ29hl1uGdEs6Q==
X-CSE-MsgGUID: XXqs4qwTTrGWZEqFWCXwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269896440"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.73])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:27:50 -0700
Date: Thu, 17 Sep 2026 09:27:47 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: Re: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set commands
Message-ID: <aquIYzwDOx6jzy3T@tlindgre-MOBL1>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-7-joro@8bytes.org>
 <aqksXLLcmFDkM9Xj@tlindgre-MOBL1>
 <aqrDUgB7nfdgzXpQ@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqrDUgB7nfdgzXpQ@8bytes.org>

Hi Jörg,

On Wed, Sep 16, 2026 at 06:31:04PM +0200, Jörg Rödel wrote:
> On Tue, Sep 15, 2026 at 02:30:36PM +0300, Tony Lindgren wrote:
> > Nice, looks like snp_get/set_vcpu_state() could quite easily make use
> > of KVM_EXPORT/IMPORT_VCPU?
> 
> That depends on whether KVM_EXPORT/IMPORT_VCPU will migrate the confidential
> VCPU state (registers) only or hypervisor state as well. The get/set_state
> helpers here only export/import the hypervisor tracking state for the guest
> VCPUs.

Oh OK, so calling for both hypervisor and confidential VCPU state would be
needed. The difference could be specified in the struct kvm_vcpu_transfer
flags?
 
> On AMD the confidential VCPU state is migrated as part of the memory image when
> guest execution has stopped on the source side.

This part for the confidential VCPU transfer matches what we are doing
for TDX.

Regards,

Tony

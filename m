Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A5476CF0;
	Wed,  2 Sep 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359033; cv=none; b=UvvtnkfU3XAift3+HhrG6F/xsVXfBg91FGZawo+Slw3/GBNXHePmtsw8ZJ01I0wI+gPk+zU9lBeRxJ8JhKkH0c8gsE4/NvYXToQT71jpCq+IQDcnqwM032RvixXGs7tlNwZ2xcJfO0m3rS6jztUlM9g2mcxkeKdMPUfatcuwbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359033; c=relaxed/simple;
	bh=qOkojzkoFJwHOtoaj8TY0af7jlHYFsxqrWKI+2tChUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK6NkEFnqjs7Z6dMDK/DjNXng9ObbNzch/IlYAzVjzVLLCsMpO8E2qrGbNGDpIn2YIA7lq7QUhQiMr1/u6QDQ3BXZ1gw6UWyCsOTQIzKaLZOypXHDL1M4Rrb3zi3DcXtrAZ0TS3tYBXkzDMHB9q7U+QvID8VBjaQrq1227iR0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=O1bpT2yO; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="O1bpT2yO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788359031; x=1819895031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeQpqZ+DrpBpsDCYWcQ4pyADFo2tlZPfVzRRjV6TOKE=;
  b=O1bpT2yOrOchq8TUtMPpY3AHMIolfQwfQgBxifP+MFS+rLP/yIfCmf4k
   2QnzwWJP3Op+HUxjLPaVsMcCZgyc5RV46NYpISu0orHGcbFvQrsefBkYo
   Tg0MltqcFMI1bSSXEKjqIeGWwH8C7QVViAIQO4ClF9Qqqk1pBdEB3HtQg
   yXuTO5BRZII5UwvMIwXxF3eodf+WTzgMYK0LeS/aS0D07H4NglCVGdDLK
   WQm2865ca3lzVVrRk0p8485LOZeIIITKUfkF7yPnMNJ9npYfCY8P5S30Q
   s0cbeZQKPfIeASEAHzDSurpDU4HIp1pc0txTieYkKdKexuKK6a55eXTCf
   A==;
X-CSE-ConnectionGUID: d5EnhaDVRTWic4QPsDj36Q==
X-CSE-MsgGUID: AQCIOH6RTC6sRYAeiLAEFA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779148800"; 
   d="scan'208";a="27412589"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 14:23:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:31265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.164:2525] with esmtp (Farcaster)
 id 99dbf840-517c-4fe2-b0d0-4db3dfe615d5; Wed, 2 Sep 2026 14:23:48 +0000 (UTC)
X-Farcaster-Flow-ID: 99dbf840-517c-4fe2-b0d0-4db3dfe615d5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 2 Sep 2026 14:23:47 +0000
Received: from dev-dsk-ehemily-1c-401a2257.eu-west-1.amazon.com
 (10.253.103.254) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Wed, 2 Sep 2026
 14:23:44 +0000
From: Emily Ehlert <ehemily@amazon.de>
To: <xin@zytor.com>
CC: <andrew.cooper3@citrix.com>, <bp@alien8.de>, <chao.gao@intel.com>,
	<corbet@lwn.net>, <dave.hansen@linux.intel.com>, <hch@infradead.org>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luto@kernel.org>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <seanjc@google.com>,
	<sohil.mehta@intel.com>, <tglx@linutronix.de>, <x86@kernel.org>,
	<nh-open-source@amazon.com>, Emily Ehlert <ehemily@amazon.de>
Subject: Re: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit controls
Date: Wed, 2 Sep 2026 14:23:36 +0000
Message-ID: <20260902142336.9955-1-ehemily@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026201911.505204-19-xin@zytor.com>
References: <20251026201911.505204-19-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> +	case MSR_IA32_VMX_EXIT_CTLS2:=0D
> +		*pdata =3D msrs->secondary_exit_ctls;=0D
> +		break;=0D
=0D
vmx_get_vmx_msr() returns msrs->secondary_exit_ctls for=0D
MSR_IA32_VMX_EXIT_CTLS2 unconditionally. But IA32_VMX_EXIT_CTLS2 is only=0D
valid if VM-exit controls advertise VM_EXIT_ACTIVATE_SECONDARY_CONTROLS=0D
(bit 63 of IA32_VMX_{TRUE_}EXIT_CTLS). On a vCPU where that bit isn't=0D
exposed to L1, nested_vmx_setup_exit_ctls() never populates=0D
secondary_exit_ctls, yet an L1 RDMSR of 0x493 still succeeds and=0D
returns 0 instead of #GP'ing as it would on bare metal.=0D
=0D
The write side already validates against=0D
vmcs_config.nested.secondary_exit_ctls; the read side should likewise gate=
=0D
on the control being advertised:=0D
=0D
	case MSR_IA32_VMX_EXIT_CTLS2:=0D
+		if (!(msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS))=0D
+			return 1;=0D
		*pdata =3D msrs->secondary_exit_ctls;=0D
		break;=0D
=0D
Thanks,=0D
Emily=0D

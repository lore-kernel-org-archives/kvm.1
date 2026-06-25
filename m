Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987443EA947
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407084; cv=none; b=ajFf4cfCyPwX8EFHXqQIfy4GDVivLr6Q5dHdKkNv/LgK89h4T67nwHl+VrHQylB4S68AXq1dX5R9Nbeav6f6vwTS4mZxbFlgf6P4y5k1mVon20/AVQWQu8ZHPr3udJexIfnQEdHblcNbgJjmZdoV1HUa6OLuPwb5SekLrAyD+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407084; c=relaxed/simple;
	bh=nb0bCTdaTLWbdAocxN5AqffDb5PE+94ws2d7TE/bN0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eRpffH+u7ZwhtSGEsW5LSTbibAWeKdwRjsNBuE7uTYJ7ZjAfShjS2E/sMfZTFPdWKvv85lFVRbP5y3gS0Vjab2tSWib5NKA22ECCgqEK1lUOrXROOtyRMQjez+VPXzlztUrbHnJx0Nkoh63V5iQN98Pp5QiumZqjdMjXcNgxTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWvMs164; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWvMs164"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37c9d82cd57so55231a91.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782407083; x=1783011883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb0bCTdaTLWbdAocxN5AqffDb5PE+94ws2d7TE/bN0U=;
        b=MWvMs164AO8ENP43HdR7wgPL4JWzGcIjxQ8lwe5oZ7sAl8HIv6kqI0ag6Npakq4hXy
         Ja5sBxQYsTUaJyXd1AZwFSlp6IYOftK4d/5QWHjECUfCvBLa24ugJ14kHX2dA8SmG38h
         /KAmNAefFi5qyhvQzwzaaTNOUkb4xdmB4aRyPdBe41+ZVQXavoQB44K4Xs81kfBwlLFN
         aB1Fh75gCILDUUjVfE0W4l9EyTMZesU0H41RdFbbe2jA+OnpqQDxxgDodpKaC/a1ghMt
         CMrBNF3lspZg4z+AsATaJ03F4iL4FHXrSIUkxk/wLKI1VlgbBAlKAmwWzvwYOytgP57q
         4ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782407083; x=1783011883;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nb0bCTdaTLWbdAocxN5AqffDb5PE+94ws2d7TE/bN0U=;
        b=OssB0aKMaqhyy2lNzkt0SDJq6fNR8l9mTdgY/saZOuWjZeAtREDY3q7WllHk2VdpGV
         XwiJ3xlP0IfjNrh+oe7CB3GktdBEPLchG0azn1s43x6uHddWtS1dCCQMKak8YKQTTN+j
         YuRjkRjZes96b7IwJO254c/CGKcJ22TzdMteOjt5S/mVj2cGRfgacyMbRN3qJJNtJXIo
         LdOC94CerEB9o/1QfTvCHAb3WFBDsS9tc0f6AqlJaatCP96zsXXW0u6p7MrSQSnNV5bN
         LEE9S6PxDjrj3GniB3Vkis8WsQD9jssTY5zMhnXgdVg+nHy5YHlij5YGJv4Z67+qv2f1
         yldA==
X-Gm-Message-State: AOJu0YwfmmF2hdH3DR5GDifZqvGxoaCKHEKawLK3dhofjLAB2TwBhyj8
	NKFriw8ZfkCM4P4PV2wqN5cnWxV3ZJyQjRc7BU1erv/tdoj1OnMukFBFvxjM/TFsNN8smDfqSLm
	3TxCAgg==
X-Received: from pjxx14.prod.google.com ([2002:a17:90b:58ce:b0:37c:5b96:37a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c50:b0:36d:bbe0:de7c
 with SMTP id 98e67ed59e1d1-37dfa2363femr3024686a91.12.1782407082437; Thu, 25
 Jun 2026 10:04:42 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:04:41 -0700
In-Reply-To: <eba94468-2507-4c1a-8107-4d13182aed71@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com> <eba94468-2507-4c1a-8107-4d13182aed71@linux.intel.com>
Message-ID: <aj1fqZEcApyd4sxi@google.com>
Subject: Re: [RFC PATCH v2 0/4] KVM: x86: TDX: Validate directly configurable
 CPUID bits
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026, Binbin Wu wrote:
> On 6/4/2026 10:33 AM, Binbin Wu wrote:
> > Hi,
> >=20
> > A host state clobbering feature on new TDX modules/platforms can lead
> > to host state corruption if KVM does not explicitly save and restore
> > the related MSR(s) during host/guest transitions. If such a feature is
> > blindly exposed to and used by TDs, it will result in unexpected behavi=
or
> > on the host.
> >=20
> > The v1 RFC [1] attempted to solve this by introducing a comprehensive
> > CPUID paranoid verification framework across VMX, SVM, and TDX. However=
,
> > as Sean pointed out in [2] and the discussion in the PUCK meeting, this
> > approach was overly complex and bled too many TDX-specific details into
> > common KVM code, creating an unnecessary maintenance burden.
> >=20
> > This v2 takes a significantly simpler, TDX-contained approach. It stric=
tly
> > validates only the TDX directly configurable CPUID bits=E2=80=94those r=
eported by
> > the TDX module in CPUID_CONFIG fields that the VMM can configure for a =
TD.
> > This is sufficient to address the host clobbering issue, as no new host
> > state clobbering features will be fixed-1. All filtering and validation
> > logic is entirely isolated within TDX code.
> >=20
> > Feedback is highly appreciated, particularly on whether this contained
> > approach strikes an acceptable balance regarding complexity.
>=20
> Hi Sean,
>=20
> Do you think this proposal is the direction to go?

Yeah, the basic gist looks good.

Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919833C1BE
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768197; cv=none; b=YnWFcweF2of1Aq7s3GP34J3mKqXprIptzX745hZ9nnbNMXUKLDWl6HonvVrjRzF7CtwQxdqgxtHMvRlGp3jlPq1+OwR7iU0+XkJqV5IKKg9MF2UQtafTfEBwyj8mcaH1/CDd2Qua7sfOUn+BD8UEQGpTlgYeevssErRMigrz7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768197; c=relaxed/simple;
	bh=6ev9e9QcXInaq1drJxD06dGCtfeXrj1+Iy1ZpqZTSq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLYjA3YsGdDnkngzsbH2G+l2I6D8dd7mzuc2FCjf7emRS/7cpnpwYm1zvN1Q/MsgRE/qKPT3cFoHfeKSo+AHCZwRQO+Puh52D+br4pK9d9nskYP8umZGCRe/dI3jBVptr99rFbyGerkVUfHfhjznn8CbS1V94tQSeKtVno6vL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shGUTkU+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shGUTkU+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso12668755ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775768195; x=1776372995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK0s53ar37Se44uIoZwyuaf/lRwoTpbUZvWHy0X9C9Y=;
        b=shGUTkU+jU6ZGz0LDQqF+2Pdpo1Q9Px7k3Al3/trwTcP8YVq4Sv3tGi0niN4sjdvjw
         PgHvznTdUljQAXEFq4tiZ0IDmSU7HH2XFEBt6FRR10rsRv72VvQQz6nkF+fUGuddE1ud
         /LxOJgwhE2qUeqFv+0Q41n+BIOowwrQIwZlRFgpJ8dASXpwCIysyuTS8X+es7IOeBROW
         gMseAtSq96ms53QEhwo0Aj/4I4CTBknVM9x0D8i8bhb9ikxf8PuCw1suYyKk10/G3yLW
         VDa7CZx/KfEHQoWQ5qpdKJtqYoW7uxGMqD3rg0SHE7ZU0oUAII0zYR7T6iVR1iNiFikW
         mxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775768195; x=1776372995;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oK0s53ar37Se44uIoZwyuaf/lRwoTpbUZvWHy0X9C9Y=;
        b=pA3lPd9JkWmay80DT1Q+DnLFlKf0HlXi3S9GxRVky4trI9E1rocuvwMDcrNYD/NbIP
         2kkIgocP1xKxgbDw3h4h1LsamCcVN/31qp9LjRUm/Vd/v0Y2j0vjr3EDMMkY7F28m/56
         Ed0OiTNoyLORHHH4SH9o9ApxSqZpShShsL9/dbO9cfeaPiKOQxzF19ngXxZ3P6ssSX3e
         4hIx9Pnd4hBntByXYBnI4bNIWnz3kb0TbTzSiXtr+oj16YV61ImXmIX0cIBSEXk9nG9i
         CEY04a1xqE3SAqwsL//gcXlocS+Gew/PF/lwXL+PZCOO6UL1OTonCinAZm3+1EieaHgG
         btUw==
X-Forwarded-Encrypted: i=1; AJvYcCVilncsBTPm3E7+AZIntnM11xesj6UP8xtnFNc+aNkCdQ5pzG0SdzDOMfYCCMx3R9QeE1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygy4D/8V7mUP9tG7et/yQtil6zepOxbt0E6qFXzBKyTslsLULw
	N9zDnzzHDRqyMo9OPegfdoSIMTxf3sWChoHUfOUIhsh+DI490kHFMzPNIAW6t2J1JgapQPAog0e
	tA91QaQ==
X-Received: from plbjw21.prod.google.com ([2002:a17:903:2795:b0:2b2:5616:36aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3202:b0:2b0:61c2:8e83
 with SMTP id d9443c01a7336-2b2d5a1a716mr4427415ad.20.1775768195214; Thu, 09
 Apr 2026 13:56:35 -0700 (PDT)
Date: Thu, 9 Apr 2026 13:56:33 -0700
In-Reply-To: <04a522a6-fbbe-42e0-8395-a9b74968b8be@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324124002.7670-1-manali.shukla@amd.com> <acwFolDAoqlY2ok8@google.com>
 <04a522a6-fbbe-42e0-8395-a9b74968b8be@amd.com>
Message-ID: <adgSgYQxF9MYABOu@google.com>
Subject: Re: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest
 bus lock exits
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, 
	x86@kernel.org, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	ravi.bangoria@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	tglx@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026, Manali Shukla wrote:
> On 3/31/2026 11:04 PM, Sean Christopherson wrote:
> > On Tue, Mar 24, 2026, Manali Shukla wrote:
> >> The intent is purely observational =E2=80=94 give hypervisor owners
> >> visibility into which guest is generating bus locks so they can act
> >> accordingly. No policy enforcement is done in the kernel. Suggestions
> >> on the approach are welcome.
> >=20
> > This makes no sense.  KVM is exiting to userspace, the hypervisor owner=
 doesn't
> > need to grep dmesg to understand *exactly* what vCPU is generating bus =
locks.
>=20
> I agree that the VMM receives KVM_EXIT_X86_BUS_LOCK and knows which vCPU
> caused it, and I am fine with that approach. However, this request came
> from a customer who wanted to know which guest is causing bus locks at
> which RIP in dmesg,

Ratelimited printks are not features. =20

> similar to how split lock detection on Intel does it.=20

Split lock #AC is something entirely different.  In that case, KVM intercep=
ts an
#AC and does NOT exit to userspace.  The printk in that case is warranted b=
ecause
the host kernel is disabling a mitigation for the thread to allow forward p=
rogress.

The analogous Intel feature is BUS_LOCK_DETECTION, and KVM's implementation
most definitely doesn't log anything to dmesg.  That was very intentional, =
as
the primary goal of the implementation was to give userspace full control o=
ver
how to react to misbehaving guests.

Sorry, but this gets a very firm NAK from me.

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8D35B646
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813373; cv=pass; b=pSatrA3hWjBgbhH/VKKvN8/00YKgR0k99zspwmzdIb84nhWD+o+jmFMkrrrtWVBZ/9FIhgmENFWKWa3aBjRqKceKxgiNDVmB/LrSHNVmy+R/Arm+zh7tK7p6Q3vNWUIj+0U9gw7Cxi7CPgA3YLOyaf9INM2/HhC97EAS8S/5UDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813373; c=relaxed/simple;
	bh=rvF5g1/rDZmcjNbpjLDLwUL2vxUYF6LacGWKkhEAzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvQQEqETiORZLpFpVWfcF85AfxH1JczEm4l36RL+/RJ8UVBUx0WZrKprcK7Ueg1GGJhoIb5d5E9UVIx8vQTRZcCvrnyidQSkrYITbY53qVZH6BHcEapylx3YW/O8/aKv7O3AFrvUU/056mbR6ajmowDA+ncbyO6F8nQmlHyWQqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/v48iJ9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P75oxKAm; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/v48iJ9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P75oxKAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776813371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvF5g1/rDZmcjNbpjLDLwUL2vxUYF6LacGWKkhEAzFE=;
	b=N/v48iJ9XrHLjpOdeoLKh+1B4N5YQ9QErOBiIhsc+r96XujN9ynIWQMHKrKFok83LtuK3x
	CeF/IGbvIqmQ2gmvXFQjvkUmN+jK2s3eMqEDaeeQasHuB8EGETwge3xAG4Vu1VpnoLM1EL
	ERI0i9FPYpqK8gFtLtkgr+X/lboSkqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-WUauvk1uPH6n2Z2qI-7eow-1; Tue, 21 Apr 2026 19:16:09 -0400
X-MC-Unique: WUauvk1uPH6n2Z2qI-7eow-1
X-Mimecast-MFC-AGG-ID: WUauvk1uPH6n2Z2qI-7eow_1776813368
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a5adc141cso171735e9.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813368; cv=none;
        d=google.com; s=arc-20240605;
        b=C/5ApwqOewDc7QlXViuuhBEdhDCdTEidheT3K6CdVZAeEVxntzcSywblCtSBvUQPTU
         N21TLREnTPU2WPuaWm3OQsjHG+jLwbmkR3q+x8kpq3S+yoxHXut4kD2WcCfCnMPiW+3x
         RT7UIpZi6W/0AZa1UQNPMwGAcgf/dGkAH0/Y5kkDTFQW92BbVRUHVyWkyhwNMO96q4Jo
         InZKiALs4bw869R29SVtoOhl0EO7RvKOauB0S4C9b3z/V7bE3e+1CLj2tbBDyzKiFE3Z
         nlFVU4kV3AbMliDZHTOyJ5o8M7/ywiHDuj+CpF1S9F+OMsqx5gHkcMHujFy5TEgHvrWB
         KB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rvF5g1/rDZmcjNbpjLDLwUL2vxUYF6LacGWKkhEAzFE=;
        fh=si2Hk4J66lOktrjXcTuVArHjNEmkqueCceQCssCNyMI=;
        b=YSU9l3+AgcADrJ+NhlTJDRHGpYHLYdT0mqdVnei8mYHbV7l+q9oPi4gTQJ1NZbcWki
         JK20GBa7JbfK8004zRR/vlqrdCjBli6i0yKo9t1rtPmQRM5679Omd6DjfEyYF636gbf7
         +NNcIegAT8QN6shJI0W9ASLGs/vQswvE/WiwKbRqX17bnxStaPn/nTXobEkA/x+ebZJZ
         +MUrQRfQ0bBM+qYglr3YJLtOYkwjRAwxkHH9xq7kzYVEY0DVgg961tv43GhM1dHTw7x4
         vCySbHVH+dXqqBkKjxyHjRLJWOiuiKTxmj7mp/Lrp4fFzTH/vqM2C6zoXC1wWsige024
         sJ/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776813368; x=1777418168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvF5g1/rDZmcjNbpjLDLwUL2vxUYF6LacGWKkhEAzFE=;
        b=P75oxKAmUGlT7A3NSkO1UoKMULLVGHJIl6NngZ/Gg4SQ6Y/JtiQ+X387hXd9oyh4uh
         qUgQ7xhrN8LWDdZA7l7/7Y9IhPq1Mi/lu4xt3ietbxDG5ry2/z45lThEWrpx4lu+qa4K
         vo1yM/a8PSOEXn+Go5dead44OWKFlrRc8fZJPZHhgN5VGdmn0dL9R4Ox4sw+etflliEo
         8WUZgNlBBlGn8F4omVBn45fcy6lCX41F3dEiAzzV7bL+XusKjYRnD5nJievJO3FD6SXB
         CbrfgjjdkzwoPeUBrxAcW3MZZK4dFzX7ltKkNx3ps4Ss+NQ9wTMkjF8dtDHCfK7ZkT9V
         WYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813368; x=1777418168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvF5g1/rDZmcjNbpjLDLwUL2vxUYF6LacGWKkhEAzFE=;
        b=ZU8vgy5EkdLO3zIU20Et87EiLrEfRhjMJUPkgHhxpD0MiMt1BYRGXGHz9bYlC/GTmx
         KZpFhWS56kBtmpEo2u3fC9W54kiEKkNvE6ameO5NmxqKphv8OJ1Xqdyc9gLDMv4B95kZ
         uRZT1IjATHj5uqre4oRUuBU8jmqynqVx2J+zMUjdTvzWgGThIkjS633wO3m998nPG765
         5tooONqfs00KkohUa9HPXMnVQxKqXuaHbke76AX+STyeIyXJCFD9x2vJbIsTCAoDBwR5
         /AZfiwBdVblSm5Qu8hi9Vj4ako9nRiit5Jd1nx+ikMYz/GZ2uKhMssN+Jqw4Rn5KvVPx
         w7Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/3OSbhYSodBPGIU2b1hXkyzd0Y4erEqNVJNxGFXnkkKVc5j1SxbfTDoc+PaFEITftx1Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQIlf+9/F6CBVUcTR5e/a9KNqEjbH0Dz8lz03ZwF/7oukYrOm
	koNigRiLS1+wRTQKv3DIT6pXTWsAJWoIGWuDFRvL0wnBNgIHbO/GfcIVYhY0kDE8tKy9vo4QTIA
	btFzhaOWMfW2c8jv3nA562wUVzbcqswTLbAoSFaSU2b/pvFl5iSchuySmVvlFJRilVPl2t73Sd8
	Cx/oFTWFCg4VDoOc9rOTq0LQk1vqjG
X-Gm-Gg: AeBDieu6Lzdgy4cKKQt29SIPjr3UdgWXBj4a6gzIjP2Lg1YbpUsZXGwDUtGgqBQG5P5
	29qMjQGgRTk5TnjxMXjDOSDk7O3Ys/gkw6FMbdTOu7kAPkrhBVYO3fYyWtB1HcpdrSfPfKr2LPN
	S+epPpeCO5GqlD3Qc0faJxNd+UUR6c18UxIv+esj4JLVe0Zuq/bYfky2LoBDGtgIk0gQGpl1/Iy
	NkAsq27l973HkOuwE65e39TVRegdXdHFIDkH2XG3rMc/XonZbftGQsWu1qb21MJ9fbi4WtXl5uE
	bzH49uDVwdZerQ==
X-Received: by 2002:a05:600c:2ed3:b0:487:1ed:6bf4 with SMTP id 5b1f17b1804b1-488fb881ef2mr184576025e9.3.1776813368325;
        Tue, 21 Apr 2026 16:16:08 -0700 (PDT)
X-Received: by 2002:a05:600c:2ed3:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-488fb881ef2mr184575845e9.3.1776813367875; Tue, 21 Apr 2026
 16:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
 <87tst49bgt.ffs@tglx>
In-Reply-To: <87tst49bgt.ffs@tglx>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Apr 2026 00:15:41 +0100
X-Gm-Features: AQROBzA-f7sp3rpU8fnpj1uJDslbMEH0D0GzFOTiqawCcO7VEhi3Y8d9vfMTjPA
Message-ID: <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Thomas Gleixner <tglx@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
> On Tue, Apr 21 2026 at 21:39, Paolo Bonzini wrote:
> > ... it's not decades, ack on VM exit is actually relatively recent (10
> > years out 20 :)). The reason why it was introduced is another killer
> > for the idea, though. Posted interrupts require it, for some reason
> > only known to Intel.
>
> That's yet another attempt to provide an halfways decent argument, but
> as anything else related to KVM/VIRT it is neither documented nor proven
> to be true.

SDM, "27.2.1 Checks on VMX Controls", under "VM-Execution Control Fields":

If the =E2=80=9Cprocess posted interrupts=E2=80=9D VM-execution control is =
1, the
following must be true: [...]
=E2=80=94 The =E2=80=9Cacknowledge interrupt on exit=E2=80=9D VM-exit contr=
ol is 1.

I grant you the "not documented" (not cross referenced to the manual
in commit 01e439be775) part, but "not proven to be true"? Neither I
nor my predecessors are *that* clueless.

And under "posted-interrupt processing" the following two steps are listed:

1. The local APIC is acknowledged; this provides the processor core
with an interrupt vector, called here the physical vector.
2. If the physical vector equals the posted-interrupt notification
vector, the logical processor continues to the next step. Otherwise, a
VM exit occurs as it would normally due to an external interrupt; the
vector is saved in the VM-exit interruption-information field.

So the reason is actually documented by the SDM: "ack intr on exit" is
needed in order to retrieve the interrupt vector, which is then
compared against the posted-interrupt notification vector. As far as
the APIC is concerned, the interrupt is gone; there's no way to "send
it back" and have it delivered after IF=3D1.

> Your claim is just another prove of the KVM handwaving approach as the
> change log which introduced this (commit a547c6db4d2f) does not mention
> it at all. In fact posted interrupt support came _three_ years after
> that and there is exactly _zero_ information about this dependency if I
> read the relevant change logs correctly.

No, posted interrupt support on the CPU (not in interrupt remapping)
arrived in the same series with commit 5a71785dde30 ("KVM: VMX: Use
posted interrupt to deliver virtual interrupt", 2013-04-16).

There were two different steps. Posted interrupt support on the CPU
was introduced in Ivy Bridge. Posted interrupt support on the IOMMU in
Broadwell (and added to KVM with commit efc644048ecd, "KVM: x86:
Update IRTE for posted-interrupts", 2015-10-01). New virt features
used to come on the "tock" instead of the "tick").

> Where exactly is the reference to posted interrupts and how did you or
> someone else establish that this hack is a requirement for posted
> interrupts in the first place?

Is reading the manual enough?

Paolo


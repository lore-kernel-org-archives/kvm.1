Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A53D3012
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451586; cv=pass; b=nYH7X0s2OYgJVcK60xeY7dW6RTBUHnW3WdsQkgd495Suvz47bPN+CjNf0qGYB8DjUrD4ljIWsTjvYq6xtHeK8DjFMBpOLbWhXxaf7yb5r8GFaO2A4upB8RsEPWWeRpUzseTJnQTA+ewTxePds74kZHEDAFuHeswvwR0zjphvNdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451586; c=relaxed/simple;
	bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC3VO3T5Hv/1ZjlQ4a+tVlRfrbPMyiReeAS5K3wIH5+agqHLSxWmb7HNT+gkdB4KDehayQumMkRLVf2ZsE1TBVQm47XTFgVG3qySHDYXpIgB0E7Iy63s3pMejdBBHuENXGY7UmQPYD9sE0f2GrlzmTg2TcaOn5AFWS68FJBogU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjXXd/Ik; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjXXd/Ik"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so140088a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785451584; cv=none;
        d=google.com; s=arc-20260327;
        b=YL/ccdTxK72nFp/QgYqtJaugyphy8Wn51sbCUaQMtjvk97XK6qm8e4628xBIA380fn
         6VkZiEOKmSPU5tFQIyqQywmWGoC+7piXHu/yKGz31cWHtrSettVQI/riCUMdztvW4sC7
         4+NzdtmqNlvEka8VCxp5b0uNZKieVbS3h1cXcrf5WC/SR9NgpbY9jt2mUnzczdcHuTgV
         jWSSg2VS6UU0ZcTbomQng07uYajXT8suPtIefX9f1PjZOLXgwh6E8m4nTHqEe2zBr6aN
         e1U0Nv9TBVfPKOjqqkQBef38W62inizFXCv/rO00NYolahPNlqY3xbgfaun4ZpdE0Y4l
         tAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        fh=wrFrF33qHPwrSBYTgmBhwAsXDIwvLPTugRZNiRRsuGM=;
        b=kzE55eGFTXQZm3gO5KETIlQhffNndlnc60+xl1GvWGCI53UurbgavnThoblQf5i1ar
         3RHDNeqh3m/VTyP1wYguG06lCWFgG36ja47c/ocAiJbenMaA44PMzZaYEQ7S72NGkHEo
         UDLUVtBzPpSCrM6Mze9zXTdjhtsKka6Dnzvt9IJzUslAqGEmBl/C6b8rj4hjN/LwvAig
         qadF+IxkpMonxn9r/zlKy5q7y+VVrR+ZIryTVS0IXYspi26yic/nykjUVjz9BygLBXEV
         63EvfFY9oRO8bhtGVuAyc6dB6rp5jDnlL718uloPpOAGbX+6g9G7bhB0xNSZtU6HirY3
         NSug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785451584; x=1786056384; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        b=VjXXd/IkuxtMiLoEN6RGA31tBEY0xFkbhcuPIQTILxqEA9Yzgktf1BHYrk2xEMiE7B
         XgjpPrWyoy3ZKWYc1IV6f0gilGJLBSzGFukI6Edyyl00YMkF4hVYoqyENE/Cckk59i+7
         FJ+150AE7I3wadiCBjHyFRl3jNrrmiKLgLLAWTOHY6LX7SV/SSPNxJ7ieS9X6rsJByQH
         86qwo46x4++q4jRT8r0JuefikuPzSoUMMWEmlLxeIOrp/WjyoH8gOx3+GKiuKKDZkmop
         tYXaEKiKMzF8SYDZeZdwVwddKFPn90CmdkYZGoxd0OLndfH74T37AzupSCLbBHPtkOgk
         abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785451584; x=1786056384;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        b=M9ARMlik2u3p6qqBGn1SY93BBY+C+DzqfjvZk3EYRN4VdAMcLB2V1VsUeDD/bZXF6q
         IudYSGFZYwOFmBiCYakIl6FVfVwdqKbHRcvUPQJLcsdsJScLYKGgdECmifnCjYLTFeNh
         O6RNHIVGzuSztTxZUoRgnlpYhxE6Z8aZo53URjg9ebeZJX/oo/MeAS26kEv8jtz1jnZ0
         lP1MhiW/98pkn1JAxTr9Ju0e3v4y0AU/usJKci4v8rD/e5L4kwf96pgEz1Gw6w+2Cqn3
         AwUdGXMANBOD7+yq1UbYb1Ub4+IRvuTbz3EMHcU+F5gr9OzWS0ozlZW1yN8js9XMrhHw
         i7FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7cRy8zm2xke1/uWUtrs/x7L0xf1uC2mzUAKObRNw29bYBkqlYm85enXUVzADYXycxzVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmyPMwfBAZ8uD0hSRkHO8t+zZxeLIbBN4CUARmGxb53T/pHJK
	oo0juzrPYbKLWhDYvT+5H19JB+4YNzy1PvHriAszO4swAbRlvBN2fH9G82H4WL8M7pPZpZTyqGn
	tMDXljg+256lct/prqTtDOYxOpuNsZuG3U50KEQBY
X-Gm-Gg: AR+sD11aQm7ufz5NxaxZBroa7FpKBbl1N1xRGyLiEe54lksHA17kuRoOqZA8dsovUmE
	PvmOd/6zk8+TBfeJsxnUZU0H1049ZG+R+24ezqnVUBUPFdxiFNtpUVtowTpD1ySpmiAkMeCNUK5
	9Va7xUxEGZCttirwEKd4Q5zlHDcQGo2Lailyfr182QW//TVq4/oMFMCi1siNe7YnQbVJ1WDWgst
	pU5oAi7imyqAz0mi5khJCDearNfmP5LCeI3lW/TiX0wWMeaMsPR3o5rucHnMuxWDY+0dEoEhJ8x
	OBxc8ARdA1XM15+tiqb7BlGorDo430mRRnPfDMNTuP6BAaz+2iyTH/JKkkZtbWCPkrQtJdWYXof
	swaNskFk9PuiH8WcesUuIny8A771LFn5IaGGauIYFpSwljg==
X-Received: by 2002:a17:90b:2f06:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-38fa68500b7mr1838360a91.4.1785451583701; Thu, 30 Jul 2026
 15:46:23 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:46:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:46:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <afEwWZksU0Fw61oT@plex>
References: <afEwWZksU0Fw61oT@plex>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:46:22 -0700
X-Gm-Features: AUfX_mztKVf-vmsid_VHO9yf9OChzZkQAo084zzlpI1FA8C_xfqYz8r7z-LEAo8
Message-ID: <CAEvNRgE8YHXVZLTQQYZJrJvnrW+WUfpGUn2XpxpkDRj1Zwi4Cw@mail.gmail.com>
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev
Cc: rppt@kernel.org, graf@amazon.com, pratyush@kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, maz@kernel.org, oupton@kernel.org, dwmw2@infradead.org, 
	alex.williamson@redhat.com, kevin.tian@intel.com, rientjes@google.com, 
	Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, baolu.lu@linux.intel.com, 
	david@kernel.org, dmatlack@google.com, mheyne@amazon.de, jgowans@amazon.com, 
	jgg@nvidia.com, pankaj.gupta.linux@gmail.com, kpraveen.lkml@gmail.com, 
	vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	roman.gushchin@linux.dev, akpm@linux-foundation.org, pjt@google.com
Content-Type: text/plain; charset="UTF-8"

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

>
> [...snip...]
>
> The Caretaker
> =============
>
> The Caretaker is a specialized, identity-mapped bare-metal executable
> attached to each vCPU. While it is installed during the initial VM setup
> and remains permanently enabled as an interpose layer between the Guest
> and KVM, it is the key architectural feature required for a VM to be
> orphaned. By providing an execution environment independent of the host
> OS, the Caretaker enables the guest workload to safely survive the host
> lifecycle transition.
>
> During normal VM operation, the Caretaker acts as a fast-path shim: it
> forwards standard VM Exits down to the backing KVM kernel module and
> handles certain exits autonomously. However, during the "Management Gap"
> (when no host OS is active and standard KVM handlers are offline), the
> Caretaker enters a standalone mode to ensure continuous guest execution
> without host intervention.
>

I think this might already be explained in different ways by the other
commenters.

I guess the main question I have is, if the Caretaker could indeed take
over caretaking during a "Management Gap", then we're adding code to
tell KVM what to do to handle some VM exits.

In that case, it would be awesome to have that functionality provided by
KVM in the first place, to avoid some number of kernel exits to the
userspace VMM.

> While this proposal focuses on its critical role in minimally disruptive
> Live Update, the Caretaker is fundamentally designed as an extensible
> primitive.

If the Caretaker can/needs to be extended, then on the other extreme,
the entirety of the userspace VMM's functionality could go into the
caretaker, and perhaps that's another direction to go, where maybe LUO
could keep some slice of userspace alive? (then the VM is no longer
orphaned)

> Its architecture allows it to be leveraged for a variety of
> other advanced virtualization use cases, such as running custom
> lightweight hypervisors or completely offloading virtualization duties
> to an accelerator card.
>
>
> [...snip...]
>

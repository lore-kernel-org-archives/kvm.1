Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01649BD7F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888947; cv=pass; b=kkV39qcFj1GUd8bG0zbqjn/Onn7xpzINRqZEnwXNW4pFXm0L9ITLouONAQG7QV5BUvI2afNS5kB7ZNsUHKl4fyvxVknQH8cSRzujlkMO5i2ZEawcEkPhbdYMFKLH8KnTjuUORHnhzaMqQwrxntB8pbhgdca7vf8eLXQudqhrqxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888947; c=relaxed/simple;
	bh=msNjM8JCH160FpndWx5PPKjxcUatum5lPEo2xPvWifA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqIf8XLnk20NaFJxuN6HVs7Sx02gi2scKt3eq2tC7VE5O9BWafO6mT8NQeF404HfzQ6QmETaWkgfwRM1CEBtPjorwRwCWx86BrYNCCxGop4FitF4ofOa9EUEvax8gwpGU+RbsAn8dpKpTNpsflErzGK+z4LF9pbbZxHXsjuA1Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peOuy1G/; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peOuy1G/"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b026208d8so3001838a34.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888944; cv=none;
        d=google.com; s=arc-20260327;
        b=XEAQl+YXC4JMzksjLX52BWW8yXDQY693xk/HtsmHOUU7y2FPwtNLnLnwF8OCEqJOpd
         YhN3S9QVEDRiXelkKk0KttR4ugnZG29gGI1EPvcOiJ2P/nNoziUH+RBittKHfFuWQDWk
         GRkNXqG/JcE/YVJzQj8oXwQkJrVT4Edq4v6aIOOz656urCtEQO0qVYDQirsRvluI+sdl
         x8Bg76/iFhltrd8E+RVIWuDELh/pgqMjUoDXIrpoHCjKmGNC0+Fz7/P2Dd/DsQXA6csk
         mAy+l0mUP3uFmqy26aU1TNY7a3tw5O3sWXLN+CVvNYXU3to+2YKx4jlXL7+844ZYU0p3
         +rsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        fh=TZFrkjqp530RGTAopPdzzqBLQwnnL9p9ojzoTzfB2X4=;
        b=ARPD6iX83VQmuxLe+lMZFk9kWsd7p2bjgFOC7OcXI9hy4aPIAvjp9Wdm23dn4p1D3q
         fTAK4Cc608AzwaEcDwrtwLWqLtkl4yHG5Wf9gDKV18i9JuUn+C8+V9cU5zrQqbryyfy/
         QOl6f43fAVzyP6zB84lY25oWL3tlDN4oO76oWdWNmvv77nSIwC7nCmC1GFpCMeGOv1U2
         vXt3LZXKh+vKLWD6ZJBebQwfFwA7tT7mJgPTjy8Pp1EsCKziGRF/q9Fmb7OK0AdLs++G
         X45KOvrQY/55U9lQDyP30JVtIwtXS9zStZeTZnqfYWxH6otv/uFpVWdZeBOhRhmAio11
         yh7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790888944; x=1791493744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        b=peOuy1G/d66jb0BNhfafDOBPZEpIYxzRs2YN4mZf//bXAiiBCyilwwC4ttVcLV6lo6
         7ei0Du+QpjJngZIrCFvawyYT3pubQvrHq/76Ytlw6p2n0x3kDkCMUDHimL5tIweTzwHP
         TJ15CDMykdCd27m77PPgWi/vfsGcvPzi5Al/B6/N7R5v8aNc1OOM1KRP/51Vot/jRgRf
         4/MG1/HQNmozKozkoAMTR77yjxJBN+vcOPrbfl8Ixacnl9pC//HdXUaxmLCCyy+pVUVF
         L7rilaXtHJUFncwsBFRs1VY2qoDsNK6e2fy99zOEqR2qlTamj2EBAepKamcoFDuu43s6
         yyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888944; x=1791493744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        b=x8UHZVUUSdhN7xZq2uQm7ldXD2iEHfuQ0ZlLAHgOp5s3/r2Nb97cJ90wXMHSE8DPqe
         /2jQJ+qC+Ju+iV7FE7Bxb68omgXJCa0ZGPr7zqDXlJ25pXD+vdNeLIcsIbG/W8Egsi5+
         ONQDDyokUGJonwsP/HExUyWJIJp/g6mpBMY1Fnxpixc4SA3iS3av6kQlWxjEd7lqga93
         CHoM046i3DS3XLC3WidmoMKYV9EQI8KseT9/6qAIHp2jwTIqjlsqPDoqQKgnAcXSI9sn
         716UlZrB/qGTTdURMPN0hZT6QGjzU98Z7h9T7iwMPAdbt7+p/RyWIlQUnrWIHGjDlglR
         ScBw==
X-Forwarded-Encrypted: i=1; AKwUvByzs82KyEqLXENGD0STJnjF3sp7HkoP+V/FJqDMpLkMN6R8YYLFzmu1UyMFqxfjoR+N1BQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mVIaCN8TUNDiyC7KikzJDXRIwxjPOmK+Gn72PPOg4+AMOP8t5i
	kH13lTil89kv765FsGeECMkNeTI2ubV2brPGcchZWymx2T0I4rI0YX7bcka6gQ5iM8V+m8tTtlc
	uw0o0Jl5UFI7ibQ51TcbXfCvRTLk2xlSYsSpn2UVC
X-Gm-Gg: AYBFou3NErC0qgBm40YDUoiZ40nvD+T2D0G8FGUCP7TrqecBgAmCj+omwDHfAYd5Ws8
	8MNWIODFUoC0oxreT+vB/DBzmG2QzoU5yhq1wPoxRgmB4i87z2lAK+lEip/peEYbU0V99wwnYaS
	mdv3n3hfvItzSGiDIuGKQw+MHQOpxjDZvrQnjcZAi7LH40oUst9os5k0uFF2BV9Nyw/GJf99EJS
	jD6+yVFd/PAq/MkqR5W2q0RqIdGciAn8LAU7e3UL6UnWCP9Mna4fuXwwDCmNxBJKkab5hkK7KIF
	CJhpzfFET7+JVUO46n7cq02f6oKyOM/VgmUljCkY3dMIrEgEyckrVZcgwceUUczY+8R0uXJLFxr
	+H9tSpgClGEGRRJZaRpL3CGU+i/GoLvV7IVJZXDPXVOanfSd0fse+StSH0s7a6jjOKsGgAbEfLs
	w2NeBrM8dvguXcoVqil31b4VFELMFV8m2P7Q==
X-Received: by 2002:a05:6808:178f:b0:4d6:93e2:5bc1 with SMTP id
 5614622812f47-4f52bac82a4mr335961b6e.66.1790888943910; Thu, 01 Oct 2026
 14:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
In-Reply-To: <20261001202234.3794060-2-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:08:26 -0700
X-Gm-Features: AclHuK9qRTMsBWUaBrJsyydGSs8bKMO-n0iK8nixdC2P8OF7DD2-ohxFc2SMwec
Message-ID: <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:24=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Reject user accesses to guest memory, which are supposed to be done only
> in the context of KVM_RUN or similar operations, if the current address
> space is not the VM's (host userspace) address space.  If KVM writes to
> guest memory after the owning host process has exited, or if the VM is
> being destroyed in the context of a different process, then writing using
> the wrong address space will corrupt a different process' memory.
>
> Reject the access but don't WARN() or KVM_BUG_ON() event though attemptin=
g
> to access guest memory with a mismatched address space is a blatant KVM
> bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
> destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force t=
he
> vCPU out of L2 in order to free the nested VMX assets, and a side effect =
of
> a nested VM-Exit is that it flushes the cached shadow VMCS12 back to gues=
t
> memory:
>
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
>
> Fix the bug broadly even though the "real" bug is that KVM abuses the
> nested VM-Exit flow for non-architectural purposes, as there may be other
> such violations lurking.  For now, punt on fixing individual bugs and
> hardening the common flows, e.g. with WARNs.
>
> Opportunistically provide wrappers in anticipation of adding more checks
> and hardening, i.e. growing the logic beyond checking current->mm.
>
> Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush=
 to memory on VMExit")
> Cc: stable@vger.kernel.org
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@goo=
gle.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks, Sean. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

I wonder if it makes sense to add similar hardening to
kvm_faultin_pfn(). What do you think?

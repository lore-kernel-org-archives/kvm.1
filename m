Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DEF4CA78F
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109416; cv=pass; b=PTxuwaHGz9AHg4E1eiPAw9Sst14NCGhi9dc0XKFnPe8cciQYlIm7AGUXkP2a2fC9b05VY2lE1edbBj2ws5Z7pyIC+T/x2zj0ncQVVW+VuZL7fLXdgm4enNNhCAwPbdzJMU6oZcu4Ib9/k5F4OLpvycr0SEhgVFIoWZLAsgCL3sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109416; c=relaxed/simple;
	bh=LigzqXSS8DEfP3cmtfyLjdc0kKiyg4jtx9CgA6a2THg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/EfzsfpEAUja9Kkn2+Hm7Z84lqk+WVzaO/ZgJv2PmQf09qSa+uA3r1bjJ7MhaKHy2gicD4W9/+WQd7mkMySRLoZ/uQ4B9FmsFzfj1jMivdDcZnAWwR5l0lhbXhbBtLDASvOzRweC8CESWqLwhV/s8bL00vyBdOFlf/rhCzhzSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HimfdTHF; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HimfdTHF"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso409605a12.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109399; cv=none;
        d=google.com; s=arc-20260327;
        b=ne9JkYgtRcHPhSEJ0yDPTBpkGW/tLe3PDcYKwamA/dhGopEne+2HRwweRGBQP07Nd4
         g+Ml9y7Ho92t0cWhwHXofAQnU70bI3bdBFDjPE/d5FBnX5+ENvVOgvRca4kD4pOyNbbo
         8JfGjmL1xUvQGUYp+E+IQPCMgzxinqWDjha++fEb+21Xby3E6J19Ku4WsYPa81vK2lUv
         6Lco2wJZdgSchmwC1i5AJAwqLPeadJAbi/w0xfAJBPvRHzZI0XcKC0tXtLW0Uw5gJ47L
         jMTuNXzwdo5cXADhX0YNxmH2eHy3RdH6IyukCRjCftxYxUJOvItR923+zmiXmo9tzAl7
         Pdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62pZ9axW+4CPUrl4s+XApJ/lHsj3XXGYs6lv21lj9Ok=;
        fh=tOA80rppsXeq2Yzk68a4fRbARzWPQSP5Hc4eUG/wZeE=;
        b=p8cWT4l6LkLPDcgDT/UP3Y6/zSABBGLOhtCBT0En0YrGjz4Xi1KrfQ/gXrqcZd5JjN
         je5+7NGhqkCf1aE+nRUvf5QyAai2/npvdqjUIJ400+/Y84ON+FvMLMcFJywAUFvxWMlT
         93sE9VAaXpxUzKJpsLB4gAIWmgUpSjdLyBG5Vc6hQbRT8bcb7ypf4UF+3mSF5yxaRJxl
         3T2xDcXVpnJWzo7A0zdXHPHc8VC+2Ru4PFzKzZNyagVacYoNGV1P4FrpjtDLGY1pXQRU
         L1SgS7fCUYEMhC0QRbKFdbwhvPWRodwHKOGsRByir9C8ZXBS4hN5Zx23b8GST4DzhFB1
         +vRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790109399; x=1790714199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=62pZ9axW+4CPUrl4s+XApJ/lHsj3XXGYs6lv21lj9Ok=;
        b=HimfdTHFHhoLVbMtuj8wsQycCBtA9G6stT2IIfuOWJ6BD48Otdp2Kp4EjiofC3FUN7
         3PfwrZalqDE7cqdtdl0KJdpBx3GZRW+kFEYETESJrxgdAHzRkhrFJDgdrILJsv9OyHnx
         tPxcRg+9JLHGn0E7f1BokR2nNsTmlvg6EJN733Ie6MGb/9pXXjE45YBnOdTyFoNJWIMs
         cUt0VjbJ3A7XMD3mMQwhhVKRqb1rOMAjVQNA5NywOafxDONMVBjSRa9IuUfBd3Zm3g6j
         KJnlPYadJ15BjA4vYtRyPiZpBZlKy6xWeO1yM9EU4H2srbm8ZGXQk5+uJtu6yok7vfbh
         S8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109399; x=1790714199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62pZ9axW+4CPUrl4s+XApJ/lHsj3XXGYs6lv21lj9Ok=;
        b=FysZJ/fDNyWNOOHsp66ntS7njj7slT39gZDq1lCaH93SKv7Hc8lJWRqhTTM+cM+4i0
         rJyzJXd1t5YI2DrbJnEA4KhwYOz5ntzF1lxT+xY77RLXOIQee+L/5pMpe7RxJlpq9cFy
         klG3Wyp+OmrOgIZU5YHfX6Yd0ujEYDjaPx5iqdZrsMR2I/zMPK/ZTKzG6UCbX3fI+P1m
         pqmqd6zxmdOaVO88aWH2XksscBDaPUooVt9IYYYaoU/irWyi6OpL4rceuyLfVYTicga7
         LMM7gCcAPPCmT8lLu90H53K4bggWVRpNDIsx31ooorFnibvHBWobV+IQ12He9nf8j3nG
         JhDw==
X-Forwarded-Encrypted: i=1; AKwUvByIpuQenUnb/qDYt72d9TkU+23lKoDqG4lbnlSCCWZCkViML5ZKniXC/VbPFsMHPTXNzYk=@vger.kernel.org
X-Gm-Message-State: AFuF++miUe+ihNbfa0NWYt7VTGndhM3Ohe4b9d+Ztj/SF2PM7eez9T4n
	ajUxuJjaHd+Mjz+1y4DO14BvLE1J90sMHzXrr21WZYgt2oPIzJq0OCUdiPe5YTol/zDIgGYr2ED
	dnJsVJwPWqrlKTCCTFE+ovHRsbBhrsWPxmiExjTJ+
X-Gm-Gg: AYBFou0KQjoxHioI5fnf9gbdPCMxWwPJu7scpvz0j6Viv+hRcThVUHyIf+4SAjx8z3y
	M++2lM3MjUVlq1TLwjL7SlBoOBVl/AHpXxg74GyFSk5q9og+hOL/Q0LA22CBFz6g21Lw7ZCjmtZ
	OXmXpztgVfqEot9PvqLIk7hCNHvJe6DyPlm4A9z+F2RpP0cQ6PhCSIbS4Mm3fU13nzyH4Swq0/O
	NqXP0QN0pa6TQL1MCTA954Qu6PvGJmf4Qidj1X3JKtN7RGAf4gu/2KiEzYXm5KfXmsNU64WJ4Ta
	HD2jQj99ewcUcEd9bAc8LzhN8q6zMGqi8kxqcqtZkK3OVbdWtunWYNzO1jv0Ur4fWAtMW4eXBXw
	V+V1MOapKo5UvGmnBVvEJFTL1gLljLGGJQTynjl3/SzqQmm/ZhAfJLLHuimfdJeRSorgmSMSGVk
	T6WKLfvijZFGLpGNgZLhhlrE4=
X-Received: by 2002:a17:907:1c94:b0:c26:1691:b368 with SMTP id
 a640c23a62f3a-c2aae0e943cmr30868666b.33.1790109398702; Tue, 22 Sep 2026
 13:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
 <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
 <arG3L3TL5_xCBtc9@google.com> <CABgObfZTbj7cSUdGEcA2xgGkSgFqZ2NnNrHJ7+uYAHP3_9idqg@mail.gmail.com>
 <arG5raFJQO0hA-Uz@google.com> <CADrL8HWS3SLqGfj0CrHhODscUq3fPdKd6Mg1M_53BFdFh4eLvw@mail.gmail.com>
 <59a45f81-8cb2-4794-a529-eab72a45b93a@redhat.com>
In-Reply-To: <59a45f81-8cb2-4794-a529-eab72a45b93a@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 22 Sep 2026 13:36:01 -0700
X-Gm-Features: AcwNN1XIUgz1BOv1EkxUY7hWgtF3ygs5uynW3bZLjeRdG1EKl46E4yC46HmqtcI
Message-ID: <CADrL8HWtafbiHA8ZL=DhMqT+GSBeajXew9QzBkVyPUyUJwiTZA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:33=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 9/22/26 01:23, James Houghton wrote:
> >> James, how are you feeling about an early morning PUCK in the near fut=
ure?
> > No problems here; the 23rd is fine. The only day I can't do in the
> > near-ish future is Oct 14. Thanks!
>
> Great.  To sum up what I would like to understand, this is it:
>
> 1) the overlap between memory protection attributes and kvm-userfault.
> It seems to me that they are almost the same, but I may be wrong.
>
> In particular, they are almost the same in that they are both
> stop-and-retry interfaces, unlike userfaultfd which hides the
> stop-and-retry behind a page fault and a stopped thread.

Hi Paolo,

They are very similar, yes. But I am unsure what the new memory
attribute work is motivated by (maybe I missed it? I don't see it in
the cover letters I checked).

KVM Userfault was motivated by post-copy live migration (for VMs with
guest_memfd memslots and as an optimization for userfaultfd-based
post-copy with conventional VMs). KVM Userfault's interface reflects
this; it uses a userspace-modifiable bitmap to track state, which has
predictable memory overhead and is fast to modify. If memory
attributes are meant to be used for post-copy as well, we'll want a
bitmap-based interface for userspace and for tracking in KVM.

Other than the interface, KVM Userfault was intentionally limited to
only EPT/NPT faults because it is always "safe" for those to return to
userspace with -EFAULT and the bad address. This means that
implementing post-copy completely requires *also* using userfaultfd
(or something else) for the other guest memory access cases. Memory
protection attributes include many of the other important
(guest-initiated) cases, so post-copy could maybe be implemented
without userfaultfd. Great!

I was assuming that these new checks would be (1) difficult to
maintain and (2) potentially cause issues with instruction emulation
(or any case where unwinding and replaying is challenging).

> 2) what strategy you have implemented, or you have in mind, to handle
> stop-and-retry for code that does many consecutive memory accesses.  The
> main one is nested vmentry/vmexit.  I have here some mostly untested
> code that splits them into prepare/commit/cancel phases, but I haven't
> dared posting it.

Ah exactly... :) This is why userfaultfd remained in the picture for a
complete post-copy implementation with KVM Userfault. From my
perspective, the only way around using userfaultfd is to add support
for nested vmentry/vmexit going back out to userspace and coming back
in, like the phases you have.

"KVM Demand Paging" in Google's downstream kernel has essentially the
same checks that you have in the memory attribute series. It uses a
netlink socket for the long flows (and waits for userspace to mark the
page as ready). Perhaps there's an argument that this would be better
than making the long flows support exiting to userspace? But I doubt
it.

> (Secondarily, we have a TDX-sized dependency between planes, memory
> attributes, VBS, and kvm-userfault.  That is probably something worth
> discussing too, sooner or later).

Yes I want to hear more, I'm not sure of all the context here. :)

Thanks!

James

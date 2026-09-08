Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393959E33E
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894794; cv=pass; b=axxlmE+UTbPWGgJjOHLPi7upylTRCAax/O7zjSh62T1Pkr+G/6TQ9rzs9r18Og1wPcn4HzfOweIPuD+fCbYPBtb7xlJOGAiIrbOsOx14sh/l+INNH3SVomnF+SR+awMvhwCBJ3IZsWJ4oiisrDCAMc+y+0OSZfQgbyI93hKbpBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894794; c=relaxed/simple;
	bh=i+PUh1GNjddjRlItZQFpQ9yZWIJbJi9QYvWdoApv6Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIx8EFRdXPgGbyWDV0OKBZCA0UhlvvU4M8JuUdfseGENZUa3kVeGIyIg6LklB+K4xReQ1i3/xVIbzk1k032dYtg4NWJcRpx27ar9dUk+1U9db6FjGjyPS3Vo0yqyCEAyGytOhlHk/57ZKDAW8XjgpBC/gnhKzG2iH5uim6GWr+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjPz4+3V; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjPz4+3V"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so29760a12.1
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 12:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788894790; cv=none;
        d=google.com; s=arc-20260327;
        b=LR51elwVX1XbnsrHwSYrsNK9SI+PoWSWfO5S7oDWX1n50AHaYIA0JlF11ydUJzZYtA
         /fEMqaIbbddDB2Vy7Hs+sonnUYCMmJCfSo/CE5lT4+EwndzLMmLZnclZj7JK3ae4Do1x
         9C9oi2toL8snRAD7ljqqswX/vbNaItN6HowOO3M5kxs1yqhSWIgo6WaeJAWjssWRCzhA
         KkNwWmEHLKmit5qxL66UDXVskn68qjvNVMdK2WyBt6hlFpQvbw8Q0OObRpcR+kFK8o2p
         TjFnliFchoZobk9i7EI6V7qAEx2259EcDzU8P1iMObSWHkq6rz69A3Us0hxqom0Qc5dO
         rMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        fh=XC3dZaIv/VKww573JcuLkI23xOxxLuHRP+u4O4JucTs=;
        b=R49wUGkOvQkOyNZAEIcb2SQmYVixkrHo819jcqk75sJvxjDqLghl31eGjsoG/tHeYg
         KJB/+RwYCalsiC3QgXEBM9UQng5OfydL/DAS8beGCJfDeS/qBJLhA7jWaNLCLJH/UpXy
         Co/FetkWdJS7YkjAuyBvUlm24WUR75LOVJd9NkYRLki8QOLT3HlwQYu83khwASlb3IrI
         tK4v59nQoCtqPj6MBZ2v4SDUQ6xxvUta+puzE6tlm4AhZ3jytjD3qXAVddpQUQ81XzT4
         qbgld1my3A+G4XBJakNzgMWcqKs9pjfUpjwiatAmd2J3KDpDZipInc2qkhQQBXZrjRn0
         J+oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788894790; x=1789499590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        b=VjPz4+3Vu+RZbDsH1o7nFaL9KaXSKC/4ED1RdbR1W/Nk16RR7l2CXQJRaKKRZ6U4PT
         tVwViYwKISmNzfKI8d23S8IGM6pzKwF8IyQJReRL0cPub/B1Goa/HsY6JOQc9FZbvKsm
         BMfsZqw7m2jTAHZqLfBro8WZ95HFos1mLCkySVzvHkcQr7xDwywD6TA0QyZpH/EfTHLq
         WaE3/rRo6tOE3+ltuIL/kcFzI93546/TeViqkWurFNyx1qt6XySbSoK1wuktS+MSzk7o
         i16KV7aIYFrknUsViCk6HRPwNZ8C7apBxeJG0QcIaXEuzGaECrQjVb4oZcNWkFqYj9Du
         NLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894790; x=1789499590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        b=ed8dcUrnjid1aMVNbWxzwVqWh8w4RX2/2AXnQwoXs6u+rHBwmcrExvLHTzuxz7ydQ5
         PfJKqVEP0J6ZxK+M5HEbbn6k9mmNd3rPFJVt7q7rPziZOlyIn0CWPKBsxO9Mx3yAT+mU
         AUrug8uCOetkn8PDWhljPfBz59Oj3rylRhN96aBn9d4R20FoQErWeV4MIlDiSKahihBT
         aqeVAGWJqe5pMo2RBZdngH28SY40FumZbEbxQ6ufG+E3RgoddQorrOdR8Qeb9HJBwr17
         Hh/zcZRp7grL9CDZmmtHRw1X2U1/p0kAv6Gdl9C9yHEsHmJQN9RVMG8jRLhjAEqRW99D
         NyiA==
X-Forwarded-Encrypted: i=1; AKwUvBwCuXerMioGca6i5Sn/eg+fu2YRMTI0T5zMaiUo0JxrLwqqfy6XJClWr2s3GwMCSAWo7dM=@vger.kernel.org
X-Gm-Message-State: AFuF++ntMt2A+xw88LMqOLMvhi61ehePE4unQaIl3+WIWAsLwTDGRUhH
	0QY7tWJhTFfrBdFPS8qQuaygUyhSYe2wfTGGHviKoDd1784R8/40TH+imKHb8Y2NnA+en+ul1G9
	Ukn/A8WUQU3WmKa4WzGOFb/t2RDJDncSkaQpbupcs
X-Gm-Gg: AYBFou1ISyZFrWRHb4ivXeIhPmGrbrIQYCDY+qUax87ZS3ZHlMTjn8MIZRmL8wa9DcW
	hY4AFe7EmGRIIxqn7Zr8ue1ByJMK5XiH81tEOTezt+9FXs6zVYfwSeo3ULw4+vFWNTfz8jh9Fhc
	Jc8+DRyrQs5zcxe4M49HtVDvRWbGuYnG08E490XOz2Zp8VRO2/UISEfse/oG/OCxCRlQ1TiYlGn
	R8Pkp9K6ESOqjN8b2XCTz5BjRxu6HDWBvQQp4JktDbHt3jnwrmCEunqwkEhB+mTLevxZOxbgFAA
	QIBmznQ+NYwZpf77os0TBmez4tAwzRM2aIXtJhmhxviKxMEeDvcTMVg=
X-Received: by 2002:a05:6402:1f06:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6a98ea6695fmr7436a12.11.1788894789633; Tue, 08 Sep 2026
 12:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
In-Reply-To: <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 8 Sep 2026 12:12:57 -0700
X-Gm-Features: AcwNN1WICV71coBtmvzzLnIk4EtMFsoM2wm7296OoHvg6Zg2kiR6KXAOxhndtII
Message-ID: <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: James Houghton <jthoughton@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
> >
> > When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> > VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
> >
> >   vmx_vcpu_free()
> >   |-> nested_vmx_free_vcpu()
> >       |-> vmx_leave_nested()
> >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> >               |-> nested_flush_cached_shadow_vmcs12()
> >                   |-> kvm_write_guest_cached()
> >                       |-> __copy_to_user(ghc->hva, ...)
> >
> > During process exit, do_exit() calls exit_mm() before closing file
> > descriptors, so vCPU destruction runs with current->mm =3D=3D NULL on a
> > borrowed lazy TLB active_mm. If the borrowed address space has a writab=
le
> > mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memo=
ry.
> >
> > Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =3D=
=3D -1
> > (e.g. during vCPU teardown or SMM entry). In these paths, KVM forces th=
e
> > vCPU out of guest mode internally--no architectural VM-exit is delivere=
d
> > to L1.
> >
> > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flu=
sh to memory on VMExit")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jim Mattson <jmattson@google.com>
>
> Hi Jim,
>
> This patch looks good for a stable backport, but I feel this kind of
> bug could easily happen again with the current API.
>
> One simple thing that would have prevented this would be to:
> 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> instead of the kvm, and
> 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.
>
> This wouldn't be as suitable for a backport, but I think it's better
> for preventing similar classes of bugs. I'm sure you (and
> Paolo/Sean/others) will have better ideas. What do you think?

There seems to be some awareness of this issue within KVM, so that may
not be necessary. Also, as Sashiko points out, we have issues with
reads as well as writes. I don't know how many choke points we'd have
to test.

AFAICT (with AI assistance), all of the current problems are rooted in
the following call to nested_vmx_vmexit():

void vmx_leave_nested(struct kvm_vcpu *vcpu)
{
        if (is_guest_mode(vcpu)) {
                vcpu->arch.nested_run_pending =3D 0;
                nested_vmx_vmexit(vcpu, -1, 0, 0);
        }
        free_nested(vcpu);
}

On the SVM side, there is no comparable faux VM-exit. Instead of
calling nested_svm_vmexit(), the teardown of SVM nested state is an
open-coded sequence. Maybe something like that would work better for
VMX?

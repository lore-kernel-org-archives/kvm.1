Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D22D8393
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052083; cv=none; b=TlSc2gktUNFVMqHQdygiOyM44pTftDyqFCcOAneLU864MkmZYxeDfgJYqN1OLGLqPKppXyZHDNSyUfeOZH8eysmr4EPh3H/7+DCE87IzMoHNOzKMGMkfKhtQNN1jzZP+nYvaMheUf6+8/u7VIuFJLL52g5ZT77+eyIJdEJKqRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052083; c=relaxed/simple;
	bh=Z4WlmMfJ0XDGS7BS32s/UsiiKs7WV2opdSLaVHXL2x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLLGFLOv3bA3uTfXgxErpvByAht2m+IAxaz1FCp9or9PWVxFBxdGrBXdzR5jOPNzBcePgdlVrwJObZ48yvgv1QA8ZLZG/jb0z95L5oNYihAIBRutoJCIMzQylhuLgTqeReXxx70NSzFnPm6L329DilFK7ksUY/VdxxXuwK6jFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkLNugw1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkLNugw1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso4320476a12.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775052080; x=1775656880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Of6IXR9kF08fb3y1GD1Duw1/k8Epn7khL83oxb2ObA=;
        b=CkLNugw1r+4em7BO186nX6SYSN2UfxFuc8ZhuHyZWYVdpfFfiFDewksp1+Qk57+aCE
         e+hMOejXl7bWL/0j8I4SEBR/NZDQng8GB9Hs9GtFx1iRyTxHqla7djJHNujDdknh2zsp
         k1DUcMYSdrWuQ5k59Z+7+AX4Mi0ff1cNmb3Y6T6xly90cpQ1KYCTxEamQw72d41ypv1M
         bg7qYaQo+YLuKhgsu3w/YrUdjTfT4iVljTfPcV24YddoDrr4VcRGb5+lHb2FALHZRn1l
         vgXy/BS6eTyiWitc/RCRvAmEpc1IWvpucPXCfpcqyyqPKzwQC68gvLJC/h8ixqSHLKpZ
         WnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052080; x=1775656880;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Of6IXR9kF08fb3y1GD1Duw1/k8Epn7khL83oxb2ObA=;
        b=drfGr5ULs6k45e9gROnJ7ZmFgbGhgiv7VABFBJ3aKJqSi+hFoVAt2FDJN49kGyk9c1
         hoO+tW7C4w182iwM/RrFe+Q4HFIh4FM7asl7MXxOHCNskTzwncVT/JOKM4dNFXWP5OQi
         OVfr5bbxwVvM99BcdM2y01Z5MwJb5Rw3tucNBIt+VLdEj/x08ByjMUxuX0He/bEXeQjH
         7BPZz6bCMb2XunAmaZA19STWAs/k+zbX6LgNFwMFFfjE/FnPjIQrOddHVuhhTvg4BRYp
         qDrCJRqaw3P9e1LknAJzIk5r0yAoiD3+2p4RJeQbwWXVVGq52JmX6Dk5MWMQ6iwFGm8l
         +AQg==
X-Forwarded-Encrypted: i=1; AJvYcCXpoyWnHdLFjA5qbeyALdtsmB+SGlAa81/lbsquS1DrwvAPykMwjkBTbBrgQ63RdA++VFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcleZbqK2xDUZuvIYi2uSU8/0RxZbHG8TfM7z2jvqX4VPCBZu
	Iox+wIyhqOB7C76m8IIhiprvz2+Vp7Bata6dDNA4WkjXM/qcO1WBHlz+Zf1YuNvCRORBw79Su1O
	ixCrCiQ==
X-Received: from pfop13.prod.google.com ([2002:a05:6a00:b4d:b0:82c:6f5f:fa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998e:b0:39c:787:f197
 with SMTP id adf61e73a8af0-39ef7688196mr4030395637.36.1775052079691; Wed, 01
 Apr 2026 07:01:19 -0700 (PDT)
Date: Wed, 1 Apr 2026 07:01:18 -0700
In-Reply-To: <4334432d-982e-4450-9281-de739c25ebfd@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319000842.1213426-2-hisamshar@gmail.com> <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
 <137f63af-a993-4b1c-a9e9-931718a47343@linuxfoundation.org>
 <f044f31d-740d-4cdb-834c-59de7691203d@gmail.com> <4334432d-982e-4450-9281-de739c25ebfd@linuxfoundation.org>
Message-ID: <ac0lGVlg4cJSNCGl@google.com>
Subject: Re: [PATCH] KVM: selftests: Guard execinfo.h inclusion for non-glibc builds
From: Sean Christopherson <seanjc@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Hisam Mehboob <hisamshar@gmail.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aqib Faruqui <aqibaf@amazon.com>, shuah@kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, Shuah Khan wrote:
> On 3/25/26 12:47, Hisam Mehboob wrote:
> > On 3/25/26 23:03, Shuah Khan wrote:
> > > On 3/24/26 12:02, Shuah Khan wrote:
> > > > On 3/18/26 18:08, Hisam Mehboob wrote:
> > > > > The backtrace() function and execinfo.h are GNU extensions availa=
ble
> > > > > in glibc but not in non-glibc C libraries such as musl. Building =
KVM
> > > > > selftests with musl-gcc fails with:
> > > > >=20
> > > > > =C2=A0=C2=A0 lib/assert.c:9:10: fatal error: execinfo.h: No such =
file or directory
> > > > >=20
> > > > > Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wra=
p
> > > > > all backtrace() usage under the same guard with a fallback messag=
e
> > > > > for non-glibc builds indicating that stack traces are not availab=
le.
> > > > >=20
> > > > > Unlike the approach of adding a weak stub for backtrace(), this
> > > > > explicitly handles the non-glibc case rather than silently provid=
ing
> > > > > an empty implementation.
> > > > >=20
> > > > > Link: https://lore.kernel.org/kvm/20250829142556.72577-7- aqibaf@=
amazon.com/
> > > > >=20
> > > > > Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
> > > > > Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
> > > > > ---
> > > > > =C2=A0 tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
> > > > > =C2=A0 1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/ te=
sting/selftests/kvm/lib/assert.c
> > > > > index b49690658c60..3442b80c37c1 100644
> > > > > --- a/tools/testing/selftests/kvm/lib/assert.c
> > > > > +++ b/tools/testing/selftests/kvm/lib/assert.c
> > > > > @@ -6,7 +6,9 @@
> > > > > =C2=A0=C2=A0 */
> > > > > =C2=A0 #include "test_util.h"
> > > > > +#ifdef __GLIBC__
> > > > > =C2=A0 #include <execinfo.h>
> > > > > +#endif
> > > > > Is __GLIBC__ defined in musl-gcc? Looks like that is the case wit=
h the
> > > > error?
> > >=20
> > > If __GLIBC__ isn't there you shouldn't see this error because the inc=
lude
> > > is in - this error doesn't make sense if __GLIBC__ isn't defined. Wha=
t
> > > am I missing?
> > >=20
> >=20
> > To clarify the compiler error you mentioned: the error log in the commi=
t
> > message shows the failure that occurs before this patch is applied. Bec=
ause
> > musl-gcc doesn't define __GLIBC__, the original unconditional <execinfo=
.h>
> > inclusion causes the build to fail. The #ifdef in my patch was intended=
 to
> > fix that exact failure.
> >=20
> > > +#ifdef __GLIBC__
> > > =C2=A0=C2=A0#include <execinfo.h>
> > > +#endif
> > >=20
> > > Also check tools/testing/selftests/bpf/test_progs.c - I think backtra=
ce()
> > > stub needs be defined only for the !__GLIBC__ case
> > >=20
> >=20
> > Looking at how bpf/test_progs.c handles it, I agree the weak stub appro=
ach
> > is much cleaner. I will implement it so that it still prints an explici=
t
> > warning message when a trace is unavailable.

I disagree.  _If_ we didn't need the __GLIBC__ #ifdef, then I would be in f=
avor
of __weak, but since the #ifdeffery is needed, using an #ifdef and a __weak=
 symbol
is double the ugliness.

IMO, the way to make this less ugly is to using a single #ifdef and a local=
 stub.

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selft=
ests/kvm/lib/assert.c
index b49690658c60..315175ca49f1 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -6,11 +6,13 @@
  */
 #include "test_util.h"
=20
-#include <execinfo.h>
 #include <sys/syscall.h>
=20
 #include "kselftest.h"
=20
+#ifdef __GLIBC__
+#include <execinfo.h>
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
@@ -57,6 +59,9 @@ static void test_dump_stack(void)
        system(cmd);
 #pragma GCC diagnostic pop
 }
+#else
+static void test_dump_stack(void) {}
+#endif
=20
 static pid_t _gettid(void)
 {

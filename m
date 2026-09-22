Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E742E8DC
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102093; cv=none; b=u4qWW1sPezRMpNLiM/f3lYi27rQL9TJAh9De4toAdj15TG2MN/sSRIMLTmt2He4s32DmFcQpWvdiQCVhCyIE27eRPWUXzGBqtKS67/sB5st2iWn/KxUkGmaOi+7lwnAcOdmFG77sCHySMEgAJRMfJezYSuAiGc3x18KJm3B436M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102093; c=relaxed/simple;
	bh=dE6blP7xL/WHMHL7CQSKGlnHE/Koi3s3g0Al+rqSe8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hzx5a9z3oXhTSTbg9nw3PQahgTMcfjy8/+aa2TgXhDh85LttziA0rL9kxOE34U52PnkBYkMr1qwHJKNyO/YGtw74deiFZxVgV9M1/Qo5trjXBQM27GydWjB2EAR1vk5xP7nGsFa2xFE51iitgzrQBXYqNyQYONUaZ940U+vWXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1EWMsv2; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1EWMsv2"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so258580a91.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790102091; x=1790706891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bJLCRmfCHJwYyMuCa+r79MDdK0EYy9EEEkSv2qnLSYw=;
        b=j1EWMsv2EE50LnRD8jla0umwc54e3jK3b8dt0HuuQ+A7VzrJReA52988NfQ8+KVWU+
         fFen+8rJhH4LWiuJ6QoKSRZHWmLzkS/5cmH1/TOL/sUQZ6moRAYaxvABFzov/T6gqxDh
         4GfgjDR44ZbQkHHGbl5MRSOj/QVtdAowwOQz0i4pEav+cvwpDx2vn+6qqwNuNvlr7iax
         2S+N1ZGEh2FWHQkXcRNSzTU3r0eNURxM/f2/HdyErHxHOAy64i2urdbzHni7Px4BQh1U
         cisBpix4KReTiLoEQojwT9PAV7lKB+SCa9hrOdmfGxJeODR1hMkLdUjeEiYmtX8WIunQ
         q5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102091; x=1790706891;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJLCRmfCHJwYyMuCa+r79MDdK0EYy9EEEkSv2qnLSYw=;
        b=1LgwH1FjW3boUe7mK3zgFqxK33Dcaq5MKwW2c15GR1P8VGJmYilMcpPsU1L7ZbbPZg
         WDZeydYvm/5rGBbGcKZm9LuD+K7i46jMa7LGlFDlJt4+uJ7s+e0NOct3JTS5S1Xd1Iq6
         PpsFatysO59jGe9RxrPqIGa5FbLe7iqKmdnOF59en9+TDNPsoOnpifomwt5NxpDsdHNG
         2SoaZE5lyGXVnD5b8PQ9PSETklJPLE+2VQqaktvJLNi+mMj8ybLOCaOcq0gBG4/oQ/6x
         1nBDmdl2TlgrOslGK9jqZlHijU8z5N/4PKnLg0irp0idTSDruZ/Bi84C99H19o323yNr
         x0DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaqR2hsB2edySjICBd0CRd+6T+dMQtvk19m0qVFlJd2rVvrs0DrjAyAYmJ2EzLqX2l8iY=@vger.kernel.org
X-Gm-Message-State: AFuF++nTbhsJD9CAw8F2m614wSxXphTz9uINIlKDl6FhF49T8sNNwnE8
	A1K34iJ+rNdY4Pjujdz6Fbxvp8apjWy67M4sFqzp8oXTw6WyNltLhqfvtw5+5IKoCMODv6YjGBw
	9F94yaA==
X-Received: from pjbnm10.prod.google.com ([2002:a17:90b:19ca:b0:3a0:7ca0:31cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2ce:b0:39e:6a80:b793
 with SMTP id 98e67ed59e1d1-3a07e5ea2bemr271386a91.35.1790102090837; Tue, 22
 Sep 2026 11:34:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:34:50 -0700
In-Reply-To: <CALMp9eThtND2KddrmySqViNsLyisdd6_ZH01s9jrA9K-_yQzXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com> <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
 <arKQJJJB8HMK0B1G@google.com> <CALMp9eQi0gm7ojijfKDZz9oZh+BK13qUkJOFrCmxjJTr5sx3Lg@mail.gmail.com>
 <arLAtdMP7LV0r-D9@google.com> <CALMp9eThtND2KddrmySqViNsLyisdd6_ZH01s9jrA9K-_yQzXg@mail.gmail.com>
Message-ID: <arLKSkliAXuww3-0@google.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, Jim Mattson wrote:
> On Tue, Sep 22, 2026 at 10:53=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Sep 22, 2026, Jim Mattson wrote:
> > > On Tue, Sep 22, 2026 at 7:26=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Tue, Sep 22, 2026, Jim Mattson wrote:
> > > > > On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > > > Gah, I hate the negative "feature" bits, I've gotten completely=
 turned around
> > > > > > multiple times trying to sort through this.
> > > > >
> > > > > Me too!
> > > > >
> > > > > > IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE=
_MBZ=3D0, but userspace
> > > > > > configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko=
 is right, it needs to
> > > > > > be declared with EMULATED_F().  I would even argue that technic=
ally this isn't a KVM
> > > > > > bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPP=
ORTED_CPUID on such
> > > > > > hosts.
> > >
> > > > > I'm trying to make it possible to run a Rome vCPU on Milan or lat=
er.
> > > > >
> > > > > SInce this is a negative feature bit, it must be retained if the =
host
> > > > > reports it. That blocks running a Rome vCPU on Milan or later.
> > > > > However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be =
run
> > > >
> > > > So, a partially defeatured Rome?  Because it sounds like the CPU re=
ports LMSLE_MBZ=3D1,
> > > > but then still allows setting EFER.LMSLE=3D1?
> > >
> > > No; it should not allow setting EFER.LMSLE=3D1. That will fail on lat=
er
> > > platforms and would block live migration from Rome to later platforms=
.
> >
> > Oh, drat, I misread the "Rome vCPU" vs. "defeatured Rome" paragraph.  Y=
ou want to
> > be able to migrate a vCPU with guest.CPUID.LMSLE_MBZ=3D1 between a non-=
defeatured,
> > vanilla Rome and Milan+ (or a defeatured Rome).  Correct?
> >
> > If so, then Sashiko is right, the flag needs to be EMULATED_F() so that=
 KVM will
> > advertise EFER_LMSLE_MBZ to userspace on the vanilla Rome host, and als=
o do the
> > right thing when guest.CPUID.EFER_LMSLE_MBZ=3D0.
>=20
> No; that's wrong.

Heh, it's not "wrong" per se, just unwise :-)

> KVM_GET_SUPPORTED_CPUID should continue to report EferLmsleUnsupported=3D=
0 on
> Rome. Otherwise, we break backwards compatibility for userspace that simp=
ly
> transfers KVM_GET_SUPPORTED_CPUID to KVM_SET_CPUID[2] or userspace that j=
ust
> doesn't know anything about EferLmsleUnsupported. The "default" for Rome =
and
> older platforms should still be to claim support for EFER.LMSLE, even tho=
ugh
> that has always been a lie.

But you can't have it both ways, KVM can't enforce a bit it doesn't support=
.

> > If not correct, then I'm even more confused, because ignoring clear_cpu=
id,
> > guest_cpu_cap_has() will only ever return true if boot_cpu_has() also r=
eturns
> > true, in which case KVM *will* reject the value because EFER_LMSLE will=
 not be
> > listed as a supported EFER bit.
> >
> >                 if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
> >                         kvm_caps.supported_efer_bits |=3D EFER_LMSLE;
> >
> > > I want KVM to abide by the guest CPUID bit and disallow setting
> > > EFER.LMSLE even on hardware that allows it.
> >
> > Right, and that requires declaring EFER_LMSLE_MBZ with EMULATED_F().
>=20
> I think you and Sashiko are both wrong. PASSTHROUGH_F() is correct for th=
is bit.
>=20
> I think I need to report EferLmsleUnsupported=3D1 in
> KVM_GET_EMULATED_CPUID, so that userspace knows it can opt-in if it
> wants to.

Hmm, I think we should have this be a "partially" emulated feature.  KVM de=
finitely
doesn't fully emulate LMSLE, and presumably anyone that cares about migrati=
ng
Rome vCPUs to Milan+ hosts is already advertising EFER_LMSLE_MBZ to the gue=
st,
i.e. doesn't need identify which KVM version have the bug and which don't.

E.g. something like this?

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 38450e9fca9a..67807cd95958 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1416,6 +1416,22 @@ static int cpuid_func_emulated(struct kvm_cpuid_entr=
y2 *entry, u32 func, u32 ind
 		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
 			entry->ecx =3D feature_bit(RDPID);
 		return 1;
+	case 0x80000008:
+		/*
+		 * Honor the guest's EFER_LMSLE_MBZ even if the underlying CPU
+		 * allows setting EFER.LMSLE, e.g. to allowing migrating a vCPU
+		 * between hosts with and without EFER.LMSLE support.  To avoid
+		 * breaking existing setups that reflect KVM's supported CPUID
+		 * into the guest, KVM doesn't advertise EFER_LMSLE_MBZ unless
+		 * it's supported by hardware, i.e. unless KVM *can't* support
+		 * EFER.LMSLE=3D1.
+		 */
+		if (include_partially_emulated &&
+		    !kvm_cpu_cap_has(X86_FEATURE_EFER_LMSLE_MBZ)) {
+			entry->ebx |=3D feature_bit(EFER_LMSLE_MBZ);
+			return 1;
+		}
+		return 0;
 	default:
 		return 0;
 	}


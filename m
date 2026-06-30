Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854232E134
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832324; cv=pass; b=pAQSAwZiFd2tnTsLDE5BCNKMDfS8OlnohvSlp46cJrsjF24OGKHzAxcwodQJfamZxyl1jfGWv5oSg1nMGXGiUNuWSCaSmR24IZDgKEvPEKvX9dq3nTZwl8436uyDmxwu82TP+EX8N8fpNNeGcZVtOMMToCGaeV/inizVn37f5uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832324; c=relaxed/simple;
	bh=hrZDgF7vfcUcbqsKeZ8056ezru3yyztiNpn9LSe10Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ4n/MHrnxhmNie4c1Yd7yFc5+9h6Ih81VwN0lQ64FbdW/IlMWJoyvKyAnBa52nR79x3Vo2QhZlVIj1TeB9byTXY63MBfMEskBrQS7dXJVPDoH++Icn67IcmFt7/lv5ks1tEokw5prWaTXJvSpNtMFgJC/4dG3yrFAg+faAQkuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wowsfxxl; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wowsfxxl"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so13478a12.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 08:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782832322; cv=none;
        d=google.com; s=arc-20260327;
        b=bNJ13tmlqkg1Ck5ib/uZ2eKMBrVbdCM172EVGDXRQEH8sOqAYKlPKre9Pi9ZiLhfBV
         YiXqfE3ROPkEpedmFFBYyM1DdYoh/DDuKIaXwttevWwaIOpfje0CrgESVCYJpTaA1TJw
         k4dNC0n2mv+g+5+mF3CT0VSVDOHUCobKGly5ZzZ0ZHYyDSp8qnb7C/b19BAqviXkcSmi
         9YVnxPJt63oEpv45FVom8X43kndi2hde4hA0pFVTIm/3oPY4FXXjGkD4H15YuhIB9pPD
         iIXhNPMKkqciND2mKuDs6/EvdWhxA8mDrj37EAIkwyQp2YAW1M8ZWkkXH4MrZuZWrCBH
         Ukcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUrWRgHGWU8z5e51oajKgawX/7aP5NXC+F/I3KuFlZA=;
        fh=32Iq/9XK//W43cEIjjn9vep7mEgpWrVX36x05cDfbNk=;
        b=MOAHZb68K5iTMPqlhbvYvCqmfsqtQUxxxUsVFdQT3lmhflzWsDERHYBuVZ7LDxY5qL
         GhgZjwHHTqv7PfFzYX4r7IGxqso7yCzmqxhhi8//Om3LIwQ+VCbtcXItQcnkItntbN/I
         /sO/McuYIvkvTFbGpKEGdG5MSKTdwtjlVWJNp8gOHFKV2yePnSmxFbIvu/U6vt1ArGbp
         WtuQZJJK5CDi60S1jjS7z0YYARHleyIxMY56kZxmUhUyr6e+9Im8MT6XFo2UB5OM0GL9
         LsCZpaceMD3Cu1iVcdw5seh9lEfC4KIEEVtT46gHBK57z1ai4+wLXJdrxk2q9i9qOY9l
         OWmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782832322; x=1783437122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUrWRgHGWU8z5e51oajKgawX/7aP5NXC+F/I3KuFlZA=;
        b=WowsfxxlkRgva8mX9WQvxR40keG3W5A45XgvSlnZv89fIfhRCtWJI6yQbSo/SBYkmU
         hZ2ehNIqTffCxmK7+bC87Egy4PJIO91DBiHBduPudiOVhJhMLhpLkM/gMHVxGwGcwegi
         oXzWS86d1dvuH/ZM7KL9AsOj34KUeE7AHNfDSBfdlvZEN823bWxPPOgKlC3GTjsFi3uB
         ldpCC1/tHks8NmOTii2PUGD1012xx6iAiNJkKibc3MGpyPH0zlgtwH1aoMdg7kKWFtCO
         1i3i21MzSQPmGGu4SH99MMgAXoLmd8mcpuIcvW+MGdNWl7t6p1x0nBOkdnPAv/MjduZ/
         7tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832322; x=1783437122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUrWRgHGWU8z5e51oajKgawX/7aP5NXC+F/I3KuFlZA=;
        b=NzzjEPyiLu3lpxzIg2n9shdSg2/VwoSnZRjCHNPS98VuCoGg+W9Pg1JorOK4omygrq
         aiLxbmOJ1nykUmyO+zuju4bP5EnqV+AHfpnxZzZIPwT2/Z4aU5cL97MBBPV2JKDhbF2l
         9nZKeBf/XXEXmUQLihZuDdIaMn4t74pgv0phmmnji/PGqYPibMdXBUZ5GYmj6vuhRT5s
         neHCDTV6QCoDnRp/9PAxqo4EXwHEq1Qy7xCh0sjm5lb6hDoo7g5S8Y2sHaELBaMLeutq
         sLUJcGwM7fisBGMFse9v3C5zfPEfPqgsKSNjTxup+BNV3gcGHLXXTnMunZsiV4j7ZU8h
         GNCA==
X-Forwarded-Encrypted: i=1; AHgh+RovoYPpJo4rMNlOvYNsSbhuTOICdavGQ5is5sVtbO96O2lW6b5SW8FDTsk5H+pUI7zMHOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1xPav1AsMTLTD7su4JI9RLZYPteLLos/8y93Hdat3Y4rGMuB
	ib2z42rqH6V7Wg0HkyxTGU3BcjHjKDtE7cq+WFDwOS/lLlLzL0FlPT7PaJ8AdOgQ/6dBeW3MILu
	1GhdxcQ4C+CwYPJOGlh+2szxq9cFgUE24MldP2Xc3
X-Gm-Gg: AfdE7clHnG1aO/au41y/S9x0EwXWcwWoucEgFdJkqPKMz77MJE0LYKN/Ec0N7d+Zs1E
	1tyfPvXI+O7sY/er1pMSRCiDTeSLJpDRCc0uRhSoc1pQd2reiAAK0tTm3fgFXHC2F0tj3//ErjO
	GtgAQglCMQM/LYxzN5tV9Ddk6QWnu1nrbut//S6WaYIo320uBYAm4LqQ8tP7iL5foSBMXILIPns
	htFyZKMSpKn6UXzRC8HZ3sCDch6zOktz/ppONPEKk2UnceoB4zOjVGpLYAgapdDCqRwW7tVHdDT
	JAFU2kU=
X-Received: by 2002:aa7:df8b:0:b0:698:a99:445 with SMTP id 4fb4d7f45d1cf-698884f9fc5mr9376a12.5.1782832321436;
 Tue, 30 Jun 2026 08:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net> <20260629125205.52394-2-zhang_wei@open-hieco.net>
In-Reply-To: <20260629125205.52394-2-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 30 Jun 2026 08:11:47 -0700
X-Gm-Features: AVVi8CfmH7gR--RQmsRN3nohzSvaOtP7G-C4hCuuv52f12gENQAEu4z6Xj4jRFE
Message-ID: <CALMp9eQTXh5itog_mcmOB6b2dFys+gLNfrdMgMV1Do7q6uGEYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: nSVM: Virtualize DecodeAssists for nested guests
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 5:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> Hardware records DecodeAssist information, i.e. the instruction length an=
d
> bytes, in the VMCB for exits such as #NPF.  KVM does not currently expose
> that information when an L2 exit is reflected to L1, so a nested hypervis=
or
> cannot consume the hardware-provided decode state and may need to fetch a=
nd
> decode the L2 instruction itself.
>
> Advertise DecodeAssists to L1 when the host supports it, and copy
> insn_len/insn_bytes from VMCB02 to VMCB12 for nested VM-Exits that
> reflect a real hardware exit.  Gate the copy on L1's guest CPUID so the
> advertised feature and the propagated state stay in sync.
>
> Report decode information only for exits that actually have fresh hardwar=
e
> state.  KVM synthesizes several nested VM-Exits, e.g. VMRUN failures,
> synthetic #NPF exits, reflected exceptions, and interrupt/NMI windows, th=
at
> do not carry VMCB02 DecodeAssist output.  Track only the verbatim VMCB02
> reflection path with nested.decode_assists_valid, clear VMCB02's decode
> fields before VMRUN, and clear VMCB12's fields for ineligible exits.  Use
> insn_len =3D=3D 0 to tell L1 that no decode information is available, and=
 avoid
> exposing stale bytes from a previous L2 exit.

You can't just set instr_len to 0 on a whim. Per the APM, "The default
number of bytes is always 15. Fewer bytes are returned only if a fault
occurs while fetching." Every #PF and #NPF VM-exit to L1 *must*
provide this information, even in cases where you can't simply copy
the information from VMCB02.

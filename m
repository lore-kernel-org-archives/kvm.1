Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAF24BBEB
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604479; cv=pass; b=M2psdso3vMjISAoqR1wHfAhtaP/gIY6bvPITK9lFkUGqRUTn1k0L9tn9ySrNVwspb57aqmRtqOfnaDngidW8w70r7vL6gAj0p+O2JowpFsPKa/XSZkFVuKBRlKT0FaEbZKzDgWcnsSmUpqJ7zFpLBeyxibRsvPcLq4I43ee6Vfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604479; c=relaxed/simple;
	bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egjU36CQfCM8b/wDjoIY+uawM8LNOGJ9w1RiPAgAlFTJNrgh7hclCAUvpQ2XfHKhSOwR7VifV9Ggz57QjBJ4oa5knobwha9FfMm9QRTWfnw9pLrDkNig1MlYSuZ1Bn0JrEO/K8UEdqP+hg/vFcDioG34vklghlHSxgGEBD62SBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4DGUQhl; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4DGUQhl"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so4618a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 16:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775604477; cv=none;
        d=google.com; s=arc-20240605;
        b=i//fMQphbzte52F2KCvSp7HIIQUg4LWto2h5zB2I52FzA4xyv4d9B8QBfJA3JI9sb8
         P5fr3zGPgs5RCz4/OynmKLCFhrnK2y1PFAUS05oZIlYuaVC6TtBGSsJAwuCJrE9bN/+g
         Q092ZJZnEX57Xs15aAPeJKwv0i1pNu2rvflTVydOP2N13VQB0zYBrCXKI5BhnROsJkR7
         D87DF326R77Rm2PokFDJjwhwjVChHGwrFYzpLNDpP9uk52IYnvkrG+gpZh4n+66HOqtR
         xCNUleRUm4/ztxu8iPt3VsMLnwbIHitysx5XlTb56UNSN7oaByLJzh0kreZV9UrwM+5Y
         pmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        fh=HyEQ0k9n4+bMAuhY+BXwwZHO1z9fV0JJq8shaLdtWjY=;
        b=hW8J6fuEUbldImHaVjz5flUGEvxG4RvgJr8kIbdLJju1os40lsxOKDX1f/gCU46kHX
         KBfkNBOQAWAgHM7rH6RQpvv577kVU4IZdUZXuivIUMHGHC028+WNzjdy0U0DpHRPNFOT
         5Xo1HC1G66320j2hHdbQd7G+OCq55JuCReNe3sNLPfAJ+uhXoL1TVrOpKArVRW4mD1CN
         iZJV+qZ1csde0b8SqBdCC4SNZ/Zhfhebmn1QrR5mZDSEC+7h332OjKX6Lhey32AhSC/i
         pRNEZzLGbyQN1H3QZkzXSTIaM3sU2oH367XT48AtSjkeNfMzA8oScQCXPN9SUxpEm4xy
         0SOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775604477; x=1776209277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        b=o4DGUQhl324AQHf3NZyWq698l82y3qvXGiEoliiKvgS7bvqcahckh60klXj1Uc0F1V
         x1SIiZRBfhI+WzVmwmn3C4g+XblT6oq4ljrBEvTjC7FGJ2L69LZgvP1/vRkisoqQLtas
         Sf5ZgP5OFSxrACKZi2tli0kYjmj3EweP9buEhG+9jzYAE3ErF5YzqJw/umbxCnzab1ZC
         TB8O1GOtR0QZRWmcmE0C+/FYW2n6lgeDZB15cry3QZZ6z3nw9d1aLElE0qCPwY36MyEM
         du16YI6Tm2nzVaDjlftrtJM0zGybJkwFW+01vPN8lZOuOXkhHmUA5qrzgEmg4Dme4EkS
         CWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604477; x=1776209277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        b=FJKcDJqSmr3y5bljkgUGxA0n6NJwecRft2oYbF12Z5l0CRLTEK/qHZvS5mhAmH2Zt+
         CUlmDQ2sF1hm2t6hP9gxoOI85N+BmdL5mdnGSoQd1Wm8EFrEic4eSPyai3QFEzeGXldA
         LioNC5lUT+M17u4S1S5jJI6BNw3ESwMq/g6ZvA/RMkfaB3zw389ezkdw/hsJDl8OAzWK
         SfyTAL8Qff/qGQWO/P3fp+EDM1wylLrjMzKP1WWBSRav7qoSE94xtrAopq3K/LK/ramd
         f6T4u6RbF9ypqVHkbJXHD2M7SwFBMt21+1QabcSNJr73g8r1/2ksp3EGo8b3PMTZPy1y
         bDRA==
X-Forwarded-Encrypted: i=1; AJvYcCUD0KRvkn2i1bMAL7fhlUFRVsmhgKHQ49mbd90JcfVN2bQsZR4kK+zosuSqsTQkFsChz+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/WP0TwDznM2JhyPJw4ocm/6HrrRcUdeVRX8X0RWU1/eUVT3u
	8JFpn69mOClvW/RpDiZb1ei7qZN9UsByJG0FIIm+VFHAefNGR1zYv9iOpNw8u3gXknyBLU1H3lx
	zeicHY7CUvEfkSTwEV9UydZSVo3z0xIomYjC87woc
X-Gm-Gg: AeBDieuHzR+C9g0e8Nk/pkK9l2b/3JjoRuQW3EmQVDrrUCWTM11+Y1J2vIDDJjB4Rz4
	os0SpPt98+pORwnWbMLKICb3G3Llt4R6g95aHTm59QoDEXT1A6dpfP6YurNsCkdxw7vIEqQL5V2
	yUrMboIoHDFKbJDuSxN7Gastro3ZyrfPum2GAE7AF5j47mfZ/2iM23PmiDJJ19anzPDS7iHhuRJ
	giDBX4xoOKxwQSUpb9cJ4ZuSQN/Lx23+f2gQY2vI4mAbW/S0B7/3BTmB7e4FA5ey6vPy4XvezKO
	1PTR51Y=
X-Received: by 2002:a05:6402:5192:b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-66f9e8a747amr11450a12.0.1775604476364; Tue, 07 Apr 2026
 16:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk>
In-Reply-To: <20260407222738.lrartp6evfp7yhti@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 16:27:43 -0700
X-Gm-Features: AQROBzBBo6GfpOq19SORVT29fsvEw6HsoB1rD-rISQykjQ6bs3K88dpb-buaNTY
Message-ID: <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:27=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 01:53:24PM -0700, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 12:11=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> > > > My proposal is as follows:
> > > >
> > > > 1. The (advanced) hypervisor can advertise to the guest (via CPUID =
bit
> > > > or MSR bit) that the short BHB clearing sequence is adequate. This =
may
> > > > mean either that the VM will only be hosted on pre-Alder Lake hardw=
are
> > > > or that the hypervisor will set BHI_DIS_S behind the back of the
> > > > guest. Presumably, this bit would not be reported if BHI_CTRL is
> > > > advertised to the guest.
> > > > 2. If the guest sees this bit, then it can use the short sequence. =
If
> > > > it doesn't see this bit, it must use the long sequence.
> > >
> > > Thats a good middle ground. Let me check with folks internally what t=
hey
> > > think about defining a new software-only bit.
> > >
> > > Third case, for a guest that doesn't want BHI_DIS_S, userspace should=
 be
> > > allowed to override setting BHI_DIS_S. Then this proposed bit can ind=
icate
> > > that long sequence is required.
> >
> > That case can be handled by the paravirtual mitigation MSRs, right?
>
> Yes. But, that was the part that received the most pushback.

What is your proposed BHI_DIS_S override mechanism, then?

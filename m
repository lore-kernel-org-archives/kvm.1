Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C053E2AB6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103611; cv=pass; b=om4TbEEzpo3q776gYBfL8AlNNHZ2238IVwuGgEWNFpGPZyt2osbzkN3bxafXg89RFiEcdK6Z4AypUQb/qjDD2Yp2kcVgmpypUFVuXVZyI/6bYTZOpSPJi7KNiL4XnOPo+EAY4UYshblOde9GviQs3v1blhUA6IvH7SAfuAjpx68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103611; c=relaxed/simple;
	bh=BibMPohthJhTfbXcbpwdRGzuy13tYrFhPSpi/AgmBSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+GXiu99c1DaXKwqiiVTD06lNCb2DA85hqdjl/xoDkLlIRmYaAW6dEakrEA5cd5TzPyeXLYh3kKE1LP49FlQFPHfONLApedlMlQQGG6kHRT84RX7EfVVmHp4u7yvs4nFVX/avzgp7KFjrSL+ca2Kss0Gmmv66dCzB0ifBYZ8qF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlvJ0ufi; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlvJ0ufi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337fa12431so60171cf.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792103608; cv=none;
        d=google.com; s=arc-20260327;
        b=f6sCeQjqU9mr2jwJzIvnbKeQD5Gv5MjRx2SUw3kKhEOJ3Y0jUds2mITj6zkvUL0vbd
         D71hS3qRTxu/AmND6HpOJ+bGY0dBhCZze1teSmkConlG8DAA92iRa8jegAGr5oxsORrn
         5kGaLRCszHg3onlfqD/Rmva2mWdtz14rI0sixmIUR6UzAP7FcBLGVq3NEfVURwdbhQkM
         sujdJ1uYKhGJnbm/fK3t/+EpfeK39DXVVVQ6wg5EohVT3wI1f+62n1HHOjUUdCGhx70p
         6bVi0xvSxl2BtzWycCt28DCPXjFd6M7jHgEOqG1bcRa0es7nMCHkfCrmGm2hYV0S7v+M
         DS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BibMPohthJhTfbXcbpwdRGzuy13tYrFhPSpi/AgmBSg=;
        fh=ZAd2spTwLPnXofEf6hzW57zEO1o9l5xpLqok+AH1FdE=;
        b=G3+CWk+EUtR/C0RWu2RvL7HOJSUdSsPLFP8yZx4K5dZASWZ5uIYb6LF6Jtn8WBWnq3
         F8imggS4qIFlM7xiwqbB7nlU3HuxAcm8WrHPW/qdjOcbe6h5UmuOxiFv+dMbcjbgkOVr
         wOoCc/5EgAzYzxwFCnkFuhtPRh698wUw9QJ+AaLoh5hAFZX8y1DXUy+PemJJ3nQpqF41
         rPcSMRlqkEiptAed6rLf8QlvBe+OT/RCVR0CirX6edIyg/YrpTGv7ZkPLOUif2RDGdca
         VUBkxfNU0aEPkUGE2tevz4+XKXbNYocSltt9dkmo5j805Hs+tFcwISIF4STP+OsA14Yp
         GSEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792103608; x=1792708408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BibMPohthJhTfbXcbpwdRGzuy13tYrFhPSpi/AgmBSg=;
        b=KlvJ0ufiX/1gevjOITkMVNOJSz9KUFbEN6M/OMYcqedSAs/JeUZ4gpTTLkdrTqbHaz
         Y2oIdzdQzMxW47JCSa3HAA76lkR8HpJJ1FyUDA6yskFxtDvAPA0TdqsPlkta/OUzYMGn
         IKYtOB7kuOYLY/TJLm2YioBapalxOpgOVgzfG9GKKTJwEm7FqllP25uDhskMhC34UYn7
         t2jF0JNqNiPCM5l22HIUbxZ3Unp5qiRlzEj0meyK+1fnWbBgF9z95hiYLn0wVCXv0Qnl
         lg0XbZ1j7OZJLP28PYPEZdTSy3kcv968Gk6JJuVSQBUy2hjd0TTRo5UfYUSQCe496tHz
         GdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103608; x=1792708408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BibMPohthJhTfbXcbpwdRGzuy13tYrFhPSpi/AgmBSg=;
        b=S+ZmuVwS0HQndKiwLpj4SKIys96MdUrHsaa7E4mZIRgUVRKcF2B59mg2TPOck4M0HW
         CxHJsZbcmZOV+W91alHwKEW9OTig9+xjl5oTSaGYyS0avyjnY23tVkK5AMEWV7NPLXOd
         HGrMFld6tGl6ujjkln7cVd7cUMBIQiJJoTykYPGHUveEF3YWmxOzwvfqditw/JGCDYW3
         5OHB/ieNOqdSjFkWuqPqZBxbAE1UExarzRAO8UewNofoRv8e1tB8wbipNzDUdpR0KWaa
         VA7oKtX6vo3irxtaJ/hnbYrPwaJIMz66oHn6h2jc63BYh+jdT9ae/Knw6dqVMgL03roI
         KD9Q==
X-Forwarded-Encrypted: i=1; AKwUvByoPPtMLshPX6svEy+M8kxdrLvW3cyfGafRQm9kAHosemG8A5QAsR4nLepBERGMuINDR3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJugis+0zbQvHZYfX7+4JoWGybTLdOpQ+ObBK8yH9HX6K/KaRjq
	p2J/8rsmDBzWFr7Wge1aFKvDOR5lnpeDRyfArqOCAFcYT1HVIygQr/2D6jsHzT2UhJusXByKmgc
	QR5h9SutsoXWGBLdRaJCa+HA+1URaxNSgzV4hHbnQ
X-Gm-Gg: AYBFou0D4d7ZV9jQv6CmYCccRatRV7LJYscp4J1TrwqgqJYAtpBJP+jtICZT4IqqH6D
	8+aaLhcgNQXk5PpZ5M/rc2SM3Mmvtvl6KFo95LsmCDDBOv/IXcr/hvbHbhk9+Bk3qjZVYoujaa+
	Cz4dd8Yl2EpBypq78mHt1ZWdRvAUgkTCHl6f8XY78aM/TfOvY2wAdZwx2h2BbZ1BLPvGNeeUTPB
	slHLmsbQZ7jwCvKCl1ZgrEAjh7rJj91dWkl8QUSEF8NTbNbtK/3eedgBb3gkO6ZyC4A4L3GUYHu
	2X1sii7ReX56WSMVnDC9LiK9A3WWeg0oHNBT58tRQeSFYsGM8Y1tpvllmfM/Bzb+qBjd91AH5aJ
	MYnnKwBxQC9KKS1qEwliWpQHD7f0VucSf0Iu9bds9ZwBGjALEWe6CIEm4DA==
X-Received: by 2002:ac8:574c:0:b0:532:d36c:7094 with SMTP id
 d75a77b69052e-53629899acemr5292911cf.4.1792103607214; Thu, 15 Oct 2026
 15:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-22-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-22-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:33:10 -0700
X-Gm-Features: AclHuK9gItNgiMo4HaNu3uew9VFJbrQSsU2AIuA_LVIEA02ZBc73weCPD4MgjW8
Message-ID: <CALMp9eRa2TYPEK2Y4bVkQq1SD6U2kQ0bZ+magc_EnhASL3jZbg@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] KVM: nSVM: Handle nested TLB flush requests
 through TLB_CONTROL
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Handle L1's requests to flush L2's TLB through the TLB_CONTROL field of
> VMCB12. According to the APM, TLB_CONTROL is not modified by VMRUN, so
> only read the field from VMCB12 but do not clear it.
>
> On nested VM-Enter, flush L2's ASID if any flush is specified in
> TLB_CONTROL. This handles TLB_CONTROL_FLUSH_ASID and
> TLB_CONTROL_FLUSH_ASID_LOCAL equally for simplicity.
>
> On nested VM-Exit, flush L1's own ASID if L1 requested a *full* TLB
> flush (i.e. TLB_CONTROL_FLUSH_ALL_ASID).
>
> Essentially, TLB_CONTROL_FLUSH_ASID[_LOCAL] cause a TLB flush on nested
> VM-Enter only, while TLB_CONTROL_FLUSH_ALL_ASID causes a TLB flush on
> both nested VM-Enter and nested VM-Exit.
>
> Additionally, sync the nested NPTs on nested VM-Enter on an ASID flush,
> as ASID flushes also invalidate guest-physical translations on SVM
> (unlike VMX, which has separate VPID-based and EPT-based flushing). Sync
> all roots, as shadow mappings are not tagged with an ASID, and there
> could be translations belonging to the outgoing or flushed ASID in
> previous roots.
>
> All TLB_CONTROL values can be handled by KVM regardless of FLUSHBYASID
> support on the underlying CPU, so keep advertising FLUSHBYASID to the
> guest unconditionally.
>
> Note, TLB_CONTROL_FLUSH_ALL_ASID is never propagated from the vmcb12 to
> the vmcb02 (unless FLUSHBYASID is not available), as this gives the
> guest the power to flush the entire physical TLB (including translations
> for the host and other VMs).
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>

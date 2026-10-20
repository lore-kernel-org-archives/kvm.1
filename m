Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792524208;
	b=PfctcH3ZnUZHocWFiVxLj4SgLZpA9nkwcWuFRJy8n3UKvY/W/j5I51uWY04UWrWd6AKu
	 iKX24JbRtUsTtoLnOF4dVbkpUUgFzqGw2Q4HB5HZsrzadOH1I210qu3vVnDZtOHa9AtE4
	 Jz0zJfasFhrrIeUH77cJCDe2avK5UoHrg6Q6WH97LdXB+FCHghSUfGkLf1FhmPZI9Ntne
	 P/Wy143AHKKdzPepVWU+5hXXV5/zUfF/x5Iw8FsfQFn4GV9MLkd5eyMims9vJhP251hwo
	 KmNUqj5Y39VDtgpTH3UodXkb29wDU8eGX41oL8NbP/44F9BFcJxeFDLz3jNlEPlUZ2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=92d3D3Mgr87umdTODi/lE5eFQwB/Iws7N5gbidF2XwA=;
	b=Lfge9le0tSbcG2RQhlqs7R+27+5uqVtVB1OTxzb6ynXbx6mBCq2HJWkkyTQHNlmOLKFj
	 nHLMkUnHo+3JkY+i+EY1vmC2NnBKOtKpnAKTdr0O6yVebpFVohlS8d02Son4LNAwBZXmE
	 SCLtt5x1yNXnB0tVhBsP7vDgGFkJgj93ZgGqWSW2YlMhK5/34ZZ9qhefQrWot/WFWxUM+
	 NMKBMRiAKzN9ncCNAHzOqQMC2pDVjkIV79AxFGVol0Wr6B9NA0oUyxtoPDgG0StpLrpFF
	 /OHfepIPraEFFI2Sh06mFqs2irSKSY1Vb7lluxgZ+A85v2Ar6UbOLspPOf24EtHO3ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jiKe4+oP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C0606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D1C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jiKe4+oP
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2359a12.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 12:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792524207; cv=none;
        d=google.com; s=arc-20260327;
        b=IPU8F1Mx6BDyY3C4FDKFKDWLdYJVw5K5f/17ZW8CP/SPZq5Mzydus0jV8FA6ehOXtN
         JzeJGwXkK1pdqmDAyxWl3GzbzJ9ndelGHow8R0I0ZIk0ccH2dv4PU/c0ZF/5iNtlQvg5
         KImHzZWTNJvwFVG87rVfJbxLYPKEhN6b/SqBbUDHKtslGqNkXEHMIZsRNRJg6wNSu6Te
         prD/oNqtuZ8IrMSpn8yVjhMb9Giscz6VJRKMdfzeDc9sBfFRitV4vFu1WSBVPvooXb29
         V9eFPwqJ+LdEJYZNpJRGm1ygHtfi7AW+Lg2BaABfl4hWLPIP1lvRlHtTvQvo+AwPhh7D
         eL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92d3D3Mgr87umdTODi/lE5eFQwB/Iws7N5gbidF2XwA=;
        fh=GmhxZeKyhas6ILsBzWnuRBhGM/xOJnjl7vhsBMu7BSY=;
        b=QJ3aXZ3op0GTea6MbtdLM93ROVnS4oRFHzMM0/84zuVdQ4Xfo90tsEo+vZdNlLzZM6
         rJmCysw+dFUbFftTw4jP6v9rMLeceewqFum4oyVpRXHDP6XJdLwBAB/q/NDR7MahUyC2
         F/+FOocmsVQCqUJeGyO9iGbvULWoNH01Okl2XfzBQIqE51Wz9CHIOKVyBV8QwIaqTQAC
         88EWq7I4Jc3biBeeANC9EAde7Pck8uwM3Omhb5PqanO4ORx7Tue+59mr3H3IlIsAFYFY
         7nyEd8ccyE6Is/g1T4pWb5Ymvr43FipbqTsybIhVZO7t+qKxdbzrYK4dNDMuS3k8q6+E
         q/MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792524207; x=1793129007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92d3D3Mgr87umdTODi/lE5eFQwB/Iws7N5gbidF2XwA=;
        b=jiKe4+oPbrePrpkG9QPZiQ7dw+DlRnpZZ1NOIX/bDrsiv0CrW9KV2by2xfDkcZ1Ms2
         4MeumDGeH0a6rzvl6PS0n6JgLT4M2o/IyqyA+hHc3V6GY9+hlUP5EYiT7ZGl/6O3xHvE
         v3wFm83jkAFTNKO82BRDZ6zWvD2jDnsfjS8mfY5FqXfdS3VDABNn5ZV711LJ1x/j0uYm
         xjtHMswOsMUlaWZLH65Er7Ryckvg9E5LddsQcIYbvN3aAw8bQ7gLjJ4PCJwpMka34eWa
         SieDaR6NOeBtOMOcjm09mpzkgCJA29bwDaxu0FSLJxlSxs8OQobpHFQaB5mhLBTqViu+
         +V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524207; x=1793129007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92d3D3Mgr87umdTODi/lE5eFQwB/Iws7N5gbidF2XwA=;
        b=f4k6LbopDXNxRShNn0YEldTtDH9tg0OkPG9eQ6QwAROqBJy45p7TW/ffv3FoPUtDNE
         dY0uxdYfu35XbqiNP+ft3GpGyMse9m36S1uGKmthxc47X8ZFjlbZQRKhAxp0d/z/j+bE
         OU1cnDfoxZXtfgbSLAHaEkNmxvyg0mC7C+UKuDf4gKyXoDd5wv8Qjou5dAQlMPvQ1syX
         uW2w91EIU4ILSoYhbnncs3mZVGePiVnIBByYPXxs6fiN/bTm9OHs3p6AwGkzd8IQoVaK
         wFR2xZN9xeXs1ar2K49CfAPErU0cC8EH6M3f7uYh2NNPCHOCyr65fBTJWliVdCSetIGB
         rDrg==
X-Forwarded-Encrypted: i=1; AKwUvBwNmqBmVgK//HtaY4g8g3oXha5WDF7ouCX+TgS1pfX6NgxjhNNrvNIaJlimWPIS9jS7Z2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN9RXVOjFDzPM+txmw9zfhF4KwvzB0v5Cx/6J3m5QDq+NDtXYh
	27CLvJZTXGbP9wHDGvjIzdqg1p1ltwDzLXaeiR0UzVsydvkmCyezhATJNqbH2kk74RdXWR8fkH8
	tlfRSYuFrlLeKMWY3r6e3GAMh26DjConQn05CUB3i
X-Gm-Gg: AYBFou3bA9dOPbEq3Gpb+EkzYoL9pRg8Q92FdHvgwyImCSjy8dOh8gYHyozMzbE2qwt
	IVQU3LVL/jFYfGZ4CDTjpi+lSUiteI/pNLzG2DMHSHWP4JbitYq9RFRVa2pAlB7IZxFV9HUuFwo
	Qz4KQG8mLTqS2MTt2OcMCjg8Wzvno1WXzg4czHT5Wqap9vnlcaLMb3yyBVed2uZmmeMEolx9OAw
	/OfDRxs3tvHAk/fpKZ2u/D4UXEDfEsqRDgHg/RPfn5q0WDqBr+1++gVucZo2GBXnZe2umWLCXoj
	N7ACKcaZbohcZTFU17XsZSwrbKP4EC8GLmWu8h/A+yF6K1oYVMk7Op8cBjd7oEe32A==
X-Received: by 2002:a05:6402:a206:10b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b3e9c2109dmr64408a12.16.1792524206232; Tue, 20 Oct 2026
 12:23:26 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 20 Oct 2026 12:23:13 -0700
X-Gm-Features: AclHuK9y3T-1DQ_5XKlLGdKY0EY3NWk_ffvPo_9uM1WVC8hfdYxS2CfvFxVzejU
Message-ID: <CALMp9eRS8Pg1E76yeFYd5Cq6O9EGcj3LMLV4X6-54ozFamsNsA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] KVM: SVM: Add support for AMD LBR Extension v2
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> This series adds SVM support for virtualizing AMD's Last Branch Record
> Extension Version 2 (LbrExtV2) in KVM.
>
> Background
> ----------
> LbrExtV2, introduced on Zen 4, is a branch sampling facility. It records
> the last taken branches in a 16-entry stack of dedicated MSRs:
>   * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
>   * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
>   * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs
>
> AMD hardware extends the VMCB save area with fields for these MSRs. When
> V_LBR (VMCB.MISC_CTL2.LBR_VIRTUALIZATION_ENABLE) is set, the CPU saves
> and restores the guest's LbrExtV2 state on VMRUN/#VMEXIT. Thus, the
> guest can use LBRv2 without interception.

Only DebugExtnCtl is actually swapped. APM vol. 2 (rev. 3.45), section
15.23.1, says:

> VMRUN only restores the guest state and #VMEXIT only saves the guest stat=
e of the LastBranchStackFromIp, LastBranchStackToIp and LastBranchStackSele=
ct MSRs.

That is, the host's LBR stack and LBR_SELECT are simply lost on VMRUN,
and the CPU doesn't put them back on #VMEXIT.

Isn't this already a problem today, before this series?

At the base commit, KVM sets V_LBR whenever the guest sets
DEBUGCTL.LBR or DEBUGCTL.BUS_LOCK_DETECT, for vmcb02 whenever L1 sets
V_LBR in vmcb12, and for all SEV-ES and SNP guests.

Since KVM knows nothing (yet) about the LBR stack fields in the VMCB,
they are all zero. So, on Zen4 and later, a VMRUN with V_LBR set wipes
out the LBR stack of an active host perf session and clears
LBR_SELECT. DebugExtnCtl *is* restored on #VMEXIT, so the host resumes
recording, but with no history and no hardware branch filter until
perf next gets around to calling amd_pmu_lbr_enable_all().

AFAICT, this series doesn't address that issue.

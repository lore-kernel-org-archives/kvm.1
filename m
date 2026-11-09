Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239163;
	b=CJGCUne5RXz4oZcVu6lVEcOCelJRSEcdIT5fJBVZHHBGe3MIlYGPZhD3ueJlCu9apZqr
	 34FIm6mgUYEFed4r1xthdXOkxBcLHIlPBGF8YsGybKKFezDbp//2B0n6fd5j4O8lz6nGj
	 CSr++M/IMvPA7qVV/7BWnTWTB+kLiq8Xd/IDqh6PJlDr7rLz3MRE+XkKwk4btyCW+79mN
	 UB7Yk7kIJJx+YR3K+d5ckwL/AVm66XW2e3K5ebdi5uPxGSJvdlfajUAec2XhXucJEcd7D
	 YGgiPKeyYCcp/ZS+P+2JWdtuE9UKDNpmbDe/ctjZsfUE2KD1m1Akzqx74gj805Ly6BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239163;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bcDVKjmr4nj4AvbK2vL3LiI7eH9RRcTEVcBAxGsZIwo=;
	b=H6+/CO/BK3FPrdP8p0U04bDEgIiqxJ/GpmM1sC6OXZBU/RkupW77MvTuGkY9lkuKYVuL
	 0eXfJxPq5iDbZ4DzVc1NQuluQwL+NRsYFvDunQR5GW+ehFNH92vQpLQIaP6aQHPlCeQ40
	 k2TIlw2KiRIPBsFaIDRu/2cM19wKtB1/rcgGhl6JtDg0NnFVE4PKC4Rk3vvigOI2hcyK7
	 hqrRJdzAtD1rdSVOrGGk40HbD8H6lXoyc1K/mNCICKzeV9NhCTXC8UBrBnYkKo5OIkyD8
	 1TNP1MF7iUMUuJj2q6ahZ2gWtBgDKfwDMyPCNkuCOdEZn9kKRnb0+gdlcJoSzelZQCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkyfHfkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712B606A336;
	Mon,  9 Nov 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkyfHfkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9A1F008A5;
	Mon,  9 Nov 2026 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239162;
	bh=bcDVKjmr4nj4AvbK2vL3LiI7eH9RRcTEVcBAxGsZIwo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IkyfHfkYU2fvCSmwfb1m4mIX+dQPi2nDa3Et30u/U+lx7tFdBL7AwR5ME2kLKqVai
	 THNvleZ/6kkp1WVQn9Z7uKy2NOUpwpj3Ml8yWo8wTlKSOOqpoqHCSKLZCddMNg3K5m
	 Yu/QkBFapT1p1jylU7rnfYygPIQrda7PosO4To0eh/ihK+9XQyn/c3U5fPJK5Marht
	 BFuW8hf8Nj+b9TPD50uqhDDbW1vZ6GELS3legALdr6dlAJeQxdtfifpKshARSyDWII
	 zAjJuzBtficDq38T73VSPOoU1JQzEtP8TNrTA3BGrKmQS34T/6hBeCCrD3raXd7xop
	 kq3LR2N2vNL+g==
Subject:
 Re: [PATCH net] ptp: kvm: report paired cycles for the active clocksource
From: netdev-bot+sashiko@kernel.org
To: wwasko@nvidia.com
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mtosatti@redhat.com, pbonzini@redhat.com, cjubran@nvidia.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 15:46:01 +0000
Message-ID: <179423916157.994134.10950100142893237366@kernel.org>
In-Reply-To: <20261105144821.5299-1-wwasko@nvidia.com>
References: <20261105144821.5299-1-wwasko@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On SEV-SNP guests with Secure TSC, the new CSID_X86_TSC branch
  in kvm_arch_ptp_get_crosststamp() (drivers/ptp/ptp_kvm_x86.c) reports…

--

ptp: kvm: report paired cycles for the active clocksource

With this patch, kvm_arch_ptp_get_crosststamp() returns the raw paired TSC
value from the KVM_HC_CLOCK_PAIRING hypercall when CSID_X86_TSC is
requested. Before, it always converted that value to kvm-clock units. When
get_device_system_crosststamp() fails with -ENODEV,
ptp_kvm_getcrosststamp() now retries once with the active clocksource and
caches it in kvm_ptp_cs_id.

> diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
> index 6cea4fe39bcfe..4dd55c60d2ce8 100644
> --- a/drivers/ptp/ptp_kvm_x86.c
> +++ b/drivers/ptp/ptp_kvm_x86.c

[ ... ]

> @@ -99,6 +104,14 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
>  	unsigned int version;
>  	long ret;
>  
> +	if (*cs_id == CSID_X86_TSC) {
> +		ret = kvm_arch_ptp_get_clock(tspec);
> +		if (ret)
> +			return ret;
> +		*cycle = clock_pair->tsc;
> +		return 0;
> +	}

[Severity: Medium]
On SEV-SNP guests with Secure TSC enabled, is clock_pair->tsc in the
guest's TSC domain?

On the host, kvm_pv_clock_pairing() fills it in from KVM's software model
of the guest TSC:

arch/x86/kvm/x86.c:kvm_pv_clock_pairing() {
    ...
	clock_pairing.tsc = kvm_read_l1_tsc(vcpu, cycle);
    ...
}

With Secure TSC, sev_vcpu_create() sets vcpu->arch.guest_tsc_protected.
After that, kvm_vcpu_write_tsc_offset() and __kvm_synchronize_tsc() both
return early, so l1_tsc_offset is never set:

	if (vcpu->arch.guest_tsc_protected)
		return;

The guest's real TSC uses the scale and offset from the ASP firmware. The
guest writes them into each AP VMSA in wakeup_cpu_via_vmgexit():

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
		vmsa->tsc_scale = snp_tsc_scale;
		vmsa->tsc_offset = snp_tsc_offset;
	}

KVM never learns that offset. The guest code also says in
vc_handle_rdtsc() that it "cannot rely on the TSC value provided by the
hypervisor".

Secure TSC guests usually run with the tsc clocksource. Neither
kvmclock_init() nor kvm_arch_ptp_init() checks for Secure TSC, so
ptp_kvm still probes on these guests. The first PTP_SYS_OFFSET_PRECISE
request gets -ENODEV from the kvm-clock attempt. Then
ptp_kvm_getcrosststamp() retries with CSID_X86_TSC and caches it:

		if (snapshot.valid && snapshot.cs_id != cs_id) {
			cs_id = snapshot.cs_id;
			WRITE_ONCE(kvm_ptp_cs_id, cs_id);

After that, get_device_system_crosststamp() compares a counter from KVM's
model domain against tk_clock_read() in the guest's hardware domain.

Won't that counter usually fall outside [cycle_last, now]? In that case
the call returns -EINVAL because history_begin is NULL, so
PTP_SYS_OFFSET_PRECISE would still fail on these guests.

If the two domains happen to be close, could it instead return a wrong
device/system time pairing with no error?

Would it make sense to skip CSID_X86_TSC when
cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) is true? More generally,
the check could apply whenever the hypervisor does not control the guest
TSC offset and scale. TDX looks fine here, because KVM loads
l1_tsc_offset and tsc_scaling_ratio from the TDX module.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105144821.5299-1-wwasko%40nvidia.com

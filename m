Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612578;
	b=GMRKYxdN/dTnWqEURoaFflMshtEytDjqVeB2TfEu0jk8Qr/ltsc6UHcPbqxXDffLDd2W
	 YzuomcDOugtm67+GXwUDsYE4svTftae96PNEXN1s8LxmVNqgmtDLTrcn2/5sCEYQ8EzIU
	 bFuNaeKNqaRENrKBEKmCZUWK63xWT7pMnpKDANa2Tvh+/yDDFho12N1xno5RGCuYT8XOr
	 Wdangh2NoyMnjDEnKvkRVfc3pVRSg++tUEaXTjPVoefEj31pCOvGSwjK9QpGbmEqFbXwG
	 eFKk1ibZdL3bg8b72Q4/lKUSaaQ6cT5gSIO/JkKkJJCI22arY/3jlc40+m2Yhshl78Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612578;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=s7UqG3TpVMZULsSsKNu6N4cz1DW5BOeuUtIPS6QDAis=;
	b=PJ9b9m3v5uKjJi3wjFR9euIfryQ+vgzWD0s8lbEW8hpAvZ6VJ7JoMwtAMVpSMahE8+lj
	 hV4CYaqqFo+TxReG4ypmbiyCRxa9rCr2lsHTEnB6AwPdJtS+9YBh/0E3qNg7MHtLV1Mk7
	 Gb4de8lyaStxPc2cpK0Ic2PVPuVNHYIOGUbdXnjBmMOHti1pIyyknH5rUi2biKiWPeR+L
	 itygxCyA0gEmjcrGAckIN09aR3KOqB0yShDSy83T2MOW1V+2GwIZE4N+/U45vUpstWN4o
	 1S2trQfygvfj+/pz2d68zP1OMvONyBe2piXsRjF00afIrbCxGrss2oNIRjb6CX6KfCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HewBOeCl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9C606A331;
	Mon,  2 Nov 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HewBOeCl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3806B1F00919;
	Mon,  2 Nov 2026 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612577;
	bh=s7UqG3TpVMZULsSsKNu6N4cz1DW5BOeuUtIPS6QDAis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HewBOeCl5pz79CSpkijwZTiI4ct1J5rEbJ6byoh4SHSvMl1udzw0FO1BHpGwylJBV
	 uQE3hkho4oZ6QlQocfKIuuc8l394gcmQ8wuHAeCL2XgV1A9KugxD/fiEpaSFNYpKqU
	 uUTElwPtEawTRD3xI+Otjo3vn6ED47Idnim/MdJJrqU7Jp7OR8txfJtiFhj67yaeXQ
	 jlD6EpdAJ3lxJ1cVqN9b1vnREtkrDzgTWh1fgCZ9mvEuzYIW1kgtmGhtVD/zjFYPEQ
	 IS6teisJNdU3jtV1ZP0D8IJWyItQrRzS7exF6tsDig8VLw6ZDt7G5QZprDG0UAoZ5V
	 26oGGOnjookOg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id B5D5F198004A;
	Mon,  2 Nov 2026 04:42:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 04:42:54 -0500
X-ME-Sender: <xms:G1voajdT0_ST4aQr5srb36ML8tbnQydvXNDb1Wa0pglc3-bl__0YRw>
    <xme:G1voamoeTNZ_tLBRDKp4twtHfohRjjLY4Xdgxca7BPM58xswyriI0uPrLDxUcPrGJ
    Ezolv1sTUcr7-5o0NIrPwaOZweizPE15Oa4Gu575E_BOCfeZSmZZDJm>
X-ME-Received: <xmr:G1voasfqxLXbh9XEw9fIfqRJKKZl5m2OFKwZnoCvtkwLsethhHA1tzFqAMI>
X-ME-Proxy-Cause: dmFkZTGUOybRtx7YsTcBd5eNLK4m3Fkm/Ey/0xNm/0ciR+HWLydMlnFcbPmj41D+Y1M07r
    Sge36pJQ3Qh+uHPDZOt/Z0sw/zsNNy1zqLH6KQvtPBB7yRjuoI07tRUvZSKeBRtG7B1sD0
    uAMxb5LPpw1ft4DgUZO3C8U4DLm5LSGomrKiANeik8BfMUm7H1eDcnAULVGAG4HLh4jZMz
    ngg87BfUvwo2om0W0IDhfELBej4BrrIUZDHHWL61OWFhiKNr8MV2yCZ9saruXg5vczc+sN
    56+11nmDJ3E6+gjErvQq7eGSpVe+dO5PhqG3Qe7j+bLHcDRWh4Xh7mITAz11RYl23v9FNE
    9WySUbJ+jWj8Ngudc6sIePDxuGI+T/pG7YC5TIoUgGstZcw1h8NKcrBTIvaG3VWxSW1vmw
    fgHGNcQRfeqJVryEov4ON6A5qd73Jtl3FkZhFcF8E0cJSOOaXI9bg8it/xzDBUw9aSRrWv
    OnaDSuZ4s2b7vbpy8V2NHpB0dML1teWBFvRl5gk63Z8q8FbTPFM2KWPijasMF0zidFe8bK
    08j54SKtHXyfp4NXSnpoIp949Lvt1fzxEg4CxmQCL/Z0ChfLObP0gnAmQqc8O3pdmwrrKZ
    r+seW0vgXh4jOQejglUudMHx7CMpM2RrChQF3ctdHz/9mo0qPfwkJ8aIjPFA
X-ME-Proxy: <xmx:G1voamlZf7s0DTyUWpxwvlxGs6f2Q_7BgepitSo_USDSMTdr-ErkkQ>
    <xmx:G1voavu_HeXJX7iywt4AiOTqV54DB5KKlTYfIjCXVCp-mJCzZgf7QQ>
    <xmx:G1voapxx6N7ltWYBSw6C5B7w4IbKrl_5MbI5rXH-QcW7rx_qsUlclA>
    <xmx:G1voaqzwqwzR_zITWWZaT7wJMmOSAzFgKSFAW3C2pdC4o69fl8QrtA>
    <xmx:HFvoan5gDyq0b69Nhm1DONlarQjnMvSSx45oTUCz0rkzanScX9i30Ews>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:42:51 -0500 (EST)
Date: Mon, 2 Nov 2026 09:42:50 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Challvy Tee <challvy.tee@gmail.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, 
	vishal.l.verma@intel.com, kai.huang@intel.com, seanjc@google.com
Subject: Re: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Message-ID: <auhbCeeG-hX6tLZ_@thinkstation>
References: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
 <20261102073244.919864-1-challvy.tee@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102073244.919864-1-challvy.tee@gmail.com>

On Mon, Nov 02, 2026 at 03:32:44PM +0800, Challvy Tee wrote:
> Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
> kdump") made native_machine_crash_shutdown() call tdx_sys_disable(),
> whose only gate is compile time (CONFIG_INTEL_TDX_HOST).  A kernel that
> never initialized the TDX module therefore still issues
> TDH.SYS.DISABLE.
> 
> In VMX non-root operation on a SEAM-capable host, SEAMCALL causes a VM
> exit instead of a native #UD.  KVM injects #UD only since
> commit 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute
> SEAMCALL or TDCALL"), first released in v6.18.  On an older host the
> VMM gets KVM_EXIT_INTERNAL_ERROR and the vCPU never resumes, so
> machine_kexec() is never reached and no vmcore is written.  Kdump is
> thus broken only in guests on SEAM-capable hosts whose hypervisor does
> not handle the exit; plain kexec is unaffected because tdx_shutdown()
> only runs as a syscore op, registered after init_tdx_module() succeeds.
> 
> Gate the SEAMCALL on X86_FEATURE_TDX_HOST_PLATFORM before issuing it,
> the way paddr_is_tdx_private() already guards its own SEAMCALL in this
> file.  Without that feature the module is never initialized, so there
> is nothing to disable; on a TDX host the gate is a no-op.
> 
> It also decouples kdump from the host KVM version -- a guest cannot
> require its host to inject the #UD.
> 
> Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Challvy Tee <challvy.tee@gmail.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

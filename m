Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524769;
	b=nt53fi8mTK0IkKHk6D0m9cHBnPBI1iERrtjngQMUMB6agDBqgOc/27pOOsAC87wFV+oV
	 lCODZ4YgkRbQEv6+hwz+0xl9p1nlgrhQ+x253g00LB23ecro3ekE6UNY3vGoCq/NdqiDU
	 Ktjm3yv2CutMxWPZOS/fjQIZs6+GIVMlFzKR8/tg0RPFtbGItf10F59h9pvsvjevv91RI
	 OkSTJKoQLbaeWW8aREVczQa5C3KSjs4nrBGeUq44krorTBtneuCDmXX9Ui4mryavcB4X2
	 8fq3zS3KjLXaQ593e22lTPHkgYuIh5QRVABgqLD9CmuLgdR9gwNwRnyYSs1SHUqpC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524769;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=Be6vEUHMTRa7Rt+PUgnFKVwuYMqlx/PkwT4URywwkWU=;
	b=qE8r9vqyZeiQGHV9oW6DvNhf7dIls8IrJhIlS1Pdv9cqkQvI/2t7Kk4FwqiCJPuWfyv6
	 tjUYRdw/TO1ZJR8Jhx2JFT3S/MUm8MdXYmI7Px4koSgMZ4Ojbe3qrlBfmcH0orcPhpfIB
	 im4ig1Brn7BkwnDVUMbj3vLrnd4vNIP1FssrfRj17Fz54da9L0UN+1IHH+sDoN/O3X1Yv
	 07AAxQ5WICfa9T4oD8w0nnKpp6FAfyzlOAqC1yDfNyHRzucEy2K0LZOEfEQoxtrhvJsxa
	 pS2hQNJ5QZnpKnpUXlxg3pMj0ZrTm4TZkz6lupR0a0fDhbIzDBLxGEOdq4wS9G1QfJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF8606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.240])
	by APP-05 (Coremail) with SMTP id zQCowAAXr7SYiAVrXDHVAQ--.4062S2;
	Tue, 24 Nov 2026 20:52:40 +0800 (CST)
Message-ID: <c661da82f9cab4bb77af20915c6db2566b3483db.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH v2 5/8] riscv: Prefer SBI DBCN console
 with UART fallback
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com
Date: Tue, 24 Nov 2026 20:52:40 +0800
In-Reply-To: <awAQYxcqIrJwxRl2@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
	 <20261105082035.133680-6-wangxiang@iscas.ac.cn> <awAQYxcqIrJwxRl2@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAAXr7SYiAVrXDHVAQ--.4062S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4Utw17Xr4DWw4kZw1UJrb_yoWrGrWxpF
	WqganIyr95Gr1vqa4kJw1kCw4UKrnFg3yFg348J34Ivr4DWrZxXw4rGayavwnxWw1fJF45
	AFsxW3sxAF4Uuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07br18
	QUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-11-20=E4=BA=94=E7=9A=84 11:08 +0100=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Nov 05, 2026 at 04:20:32PM +0800, Xiang W wrote:
> > CONFIG_SBI_CONSOLE already routes output through SBI DBCN, but console
> > setup still always went through the UART init path. uart0_init_fdt()
> > could skip a missing UART while uart0_init_acpi() aborted, so EFI/ACPI
> > guests without a described MMIO UART could not print.
> >=20
> > Probe SBI_EXT_DBCN first. When it is available, use
> > SBI_EXT_DBCN_CONSOLE_WRITE and skip UART setup. Otherwise fall back to
> > the existing FDT or ACPI UART path. This keeps a UART fallback (as
> > required by the server platform spec on ACPI systems) while allowing
>=20
> Your patch actually didn't support the fallback for early prints.
> Let's go with the following approach instead.

Thanks for the diff.

I'll use it as the base for v3, with one policy change: keep UART
when initialization succeeds and only fall back to DBCN if there is
no usable UART. Each DBCN write is an SBI ecall, which is slower
than an MMIO UART store, so the fast path should stay on UART when
one is present. Guests without an MMIO UART still print via DBCN.

I'll send v3 shortly.

Thanks,
Xiang
>=20
> diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> index b11634046b8f..e92c9288b3ad 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -28,7 +28,12 @@
> =C2=A0static volatile u8 *uart0_base =3D UART_EARLY_BASE;
> =C2=A0static u32 uart0_reg_width =3D 1;
> =C2=A0static u32 uart0_reg_shift;
> -static struct spinlock uart_lock;
> +static struct spinlock console_lock;
> +#ifdef CONFIG_SBI_CONSOLE
> +static bool prefer_dbcn =3D true;
> +#else
> +static bool prefer_dbcn =3D false;
> +#endif
> =C2=A0
> =C2=A0static u32 uart0_read(u32 num)
> =C2=A0{
> @@ -71,16 +76,15 @@ static void uart0_init_fdt(void)
> =C2=A0				break;
> =C2=A0		}
> =C2=A0
> -#ifdef CONFIG_SBI_CONSOLE
> -		uart0_base =3D NULL;
> -		return;
> -#else
> =C2=A0		if (ret) {
> +			if (prefer_dbcn) {
> +				uart0_base =3D NULL;
> +				return;
> +			}
> =C2=A0			printf("%s: Compatible uart not found in the device tree, aborti=
ng...\n",
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__);
> =C2=A0			abort();
> =C2=A0		}
> -#endif
> =C2=A0	} else {
> =C2=A0		const fdt32_t *val;
> =C2=A0		int len;
> @@ -102,17 +106,23 @@ static void uart0_init_fdt(void)
> =C2=A0
> =C2=A0static void uart0_init_acpi(void)
> =C2=A0{
> -	assert_msg(false, "ACPI not available");
> +	if (prefer_dbcn)
> +		uart0_base =3D NULL;
> +	else
> +		assert_msg(false, "ACPI UART not supported");
> =C2=A0}
> =C2=A0
> =C2=A0void io_init(void)
> =C2=A0{
> +	if (prefer_dbcn && !sbi_probe(SBI_EXT_DBCN))
> +		prefer_dbcn =3D false;
> +
> =C2=A0	if (dt_available())
> =C2=A0		uart0_init_fdt();
> =C2=A0	else
> =C2=A0		uart0_init_acpi();
> =C2=A0
> -	if (uart0_base !=3D UART_EARLY_BASE) {
> +	if (!prefer_dbcn && uart0_base !=3D UART_EARLY_BASE) {
> =C2=A0		printf("WARNING: early print support may not work. "
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Found uart at %p, but early=
 base is %p.\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uart0_base, UART_EARLY_BASE)=
;
> @@ -126,31 +136,30 @@ void sbi_puts(const char *s)
> =C2=A0	unsigned long hi =3D upper_32_bits(addr);
> =C2=A0	unsigned long lo =3D lower_32_bits(addr);
> =C2=A0
> -	spin_lock(&uart_lock);
> +	spin_lock(&console_lock);
> =C2=A0	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE, strlen(s), lo,=
 hi, 0, 0, 0);
> -	spin_unlock(&uart_lock);
> +	spin_unlock(&console_lock);
> =C2=A0}
> =C2=A0
> =C2=A0void uart0_puts(const char *s);
> =C2=A0void uart0_puts(const char *s)
> =C2=A0{
> =C2=A0	assert(uart0_base);
> -	spin_lock(&uart_lock);
> +	spin_lock(&console_lock);
> =C2=A0	while (*s) {
> =C2=A0		while (!(uart0_read(UART_LSR_OFFSET) & UART_LSR_THRE))
> =C2=A0			;
> =C2=A0		uart0_write(0, *s++);
> =C2=A0	}
> -	spin_unlock(&uart_lock);
> +	spin_unlock(&console_lock);
> =C2=A0}
> =C2=A0
> =C2=A0void puts(const char *s)
> =C2=A0{
> -#ifdef CONFIG_SBI_CONSOLE
> -	sbi_puts(s);
> -#else
> -	uart0_puts(s);
> -#endif
> +	if (prefer_dbcn)
> +		sbi_puts(s);
> +	else
> +		uart0_puts(s);
> =C2=A0}
> =C2=A0
> =C2=A0/*

